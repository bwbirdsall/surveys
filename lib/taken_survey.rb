class TakenSurvey < ActiveRecord::Base
  belongs_to :survey
  has_many :answered_questions
end
