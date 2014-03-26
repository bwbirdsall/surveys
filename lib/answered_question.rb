class AnsweredQuestion < ActiveRecord::Base
  belongs_to :taken_survey
  belongs_to :answer
  belongs_to :question
end
