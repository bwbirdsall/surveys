require 'rspec'
require 'active_record'
require 'shoulda-matchers'

require 'survey'
require 'question'
require 'taken_survey'
require 'answered_question'
require 'answer'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.before(:each) do
    Survey.all { |survey| survey.destroy }
    Question.all { |question| question.destroy }
    TakenSurvey.all { |survey| survey.destroy }
    AnsweredQuestion.all { |question| question.destroy }
    Answer.all { |answer| answer.destroy }
  end
end
