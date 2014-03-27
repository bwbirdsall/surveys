require 'active_record'

require './lib/survey'
require './lib/question'
require './lib/taken_survey'
require './lib/answered_question'
require './lib/answer'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome_menu
  menu_choice = nil
  until menu_choice == 'x'
    system('clear')
    puts "*******************************************"
    puts "***** WELCOME * TO * SURVEYMAKER 2000 *****"
    puts "* WE * ARE * SO * GLAD * YOU * ARE * HERE *"
    puts "*******************************************\n\n"
    puts "Enter (t) to take a survey, (m) to make a survey, or (v) to view a survey's results."
    puts "Enter (x) to exit SURVEYMAKER 2000"
    menu_choice = gets.chomp
    case menu_choice
    when 't'
      take_survey
    when 'm'
      make_survey
    when 'v'
      survey_results
    when 'x'
      puts "Goodbye, and thank you for your survey time!"
      exit
    else
      puts "Invalid input. Try again!"
    end
  end
end

def survey_results
  system('clear')
  puts 'Which survey would you like to take? (enter the id number next to the survey)'
  Survey.all.each {|survey| puts "\tId:" + survey.id.to_s + ' ' + survey.name }
  survey_choice = gets.chomp.to_i
  survey = Survey.find(survey_choice)
  results = {}
  questions_count = {}
  t_s = survey.taken_surveys
  t_s.each do |taken_survey|
    a_q = taken_survey.answered_questions
    a_q.each do |answered_question|
      question_key = answered_question.question_id
      answer_key = answered_question.answer_id

      if questions_count[question_key].nil?
        questions_count[question_key] = 1
      else
        questions_count[question_key] += 1
      end

      if results[question_key].nil?
        count = 0
      elsif count = results[question_key][answer_key].nil?
        count = 0
      else
        count = results[question_key][answer_key]
      end
      count += 1
      if results[question_key].nil?
        results[question_key] = {answer_key => count}
      else
        results[question_key][answer_key] = count
      end
    end
  end
  puts "Here are your survey results:"
  results.each do |question_key, answer_hash|
    puts "For the question '#{Question.find(question_key).question}':"
    answer_hash.each do |answer_key, count|
      puts "\tThe answer '#{Answer.find(answer_key).answer}' was chosen #{count} times, #{((count.to_f/questions_count[question_key].to_f)*100.0).to_i}% of answers."
    end
  end
  gets
end

def make_survey
  system('clear')
  puts "SURVEYMAKER 2000 SURVEY EDITOR\n\n"
  puts "Enter the name of the survey you would like to create."
  survey_name = gets.chomp
  survey = Survey.new(:name => survey_name)
  until survey.save
    puts "That is not a valid name for a survey."
    survey.errors.full_messages.each { |message| puts message}
    puts "Reenter the name of the survey you would like to create."
    survey_name = gets.chomp
    survey.update(:name => survey_name)
  end

  puts "How many questions would you like to have on this survey?"
  q_number = gets.chomp.to_i
  until q_number > 0
    puts "Please enter more than zero questions."
    q_number = gets.chomp.to_i
  end
  q_number.times do
    puts "Enter the question you would like to put on the survey:"
    question_wording = gets.chomp
    new_question = survey.questions.new(:question => question_wording)
    until new_question.save
      puts "That is not a valid question."
      new_question.errors.full_messages.each { |message| puts message }
      puts "Enter a valid wording for the question you would like to put on the survey."
      question_wording = gets.chomp
      new_question.update(:question => question_wording)
    end
    puts "How many possible answers does this question have?"
    a_number = gets.chomp.to_i
    until a_number.to_i > 0
      puts "Please enter a number larger than zero."
      a_number = gets.chomp.to_i
    end
    answer_code_int = 97
    a_number.times do
      puts "Enter one possible answer to the question:"
      answer_wording = gets.chomp
      answer_code = answer_code_int.chr
      new_answer = new_question.answers.new(:answer => answer_wording, :answer_code => answer_code)
      until new_answer.save
        puts "That is not a valid answer wording."
        new_answer.errors.full_messages.each { |message| puts message }
        puts "Enter a valid wording for the answer you would like to add for this question."
        answer_wording = gets.chomp
        new_answer.update(:answer => answer_wording)
      end
      answer_code_int += 1
    end
  end
  puts "Your survey has been created. Press enter to return to the main menu."
  gets
end

def take_survey
  system('clear')
  puts "SURVEYMAKER 2000 SURVEY TAKER\n\n"

  puts "Please enter your name, or a pseudonym under which you would like to fill out this survey."
  nom_de_guerre = gets.chomp
  puts 'Which survey would you like to take? (enter the id number next to the survey)'
  Survey.all.each {|survey| puts "\tId:" + survey.id.to_s + ' ' + survey.name }
  survey_choice = gets.chomp.to_i
  survey = Survey.find(survey_choice)
  this_survey = survey.taken_surveys.create(:taker_name => nom_de_guerre)
  survey.questions.each do |question|
    system('clear')
    puts question.question
    question.answers.each do |answer|
      puts "\t" + answer.answer_code + ':  ' + answer.answer
    end
    puts "Enter your answer choice:"
    answer_choice = gets.chomp
    until (Answer.find_by :answer_code => answer_choice, :question_id => question.id) != nil
      puts "Please enter a valid answer."
      answer_choice = gets.chomp
    end
    this_survey.answered_questions.create(:question_id => question.id, :answer_id => (Answer.find_by :answer_code => answer_choice).id)
  end
  puts "Thank you for taking the '#{survey.name}' survey."
end

welcome_menu











