class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  has_many :answered_questions
  validates :question, :presence => true, :length => {minimum: 10}
end
