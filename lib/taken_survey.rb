class TakenSurvey < ActiveRecord::Base
  belongs_to :survey
  has_many :answered_questions
  validates :taker_name, :presence => true
end
