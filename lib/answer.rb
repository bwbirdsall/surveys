class Answer <ActiveRecord::Base
  belongs_to :question
  has_many :answered_questions
  validates :answer, :presence => true
  validates :answer_code, :presence => true, :length => { is: 1 }, :uniqueness => { :scope => :question_id  }
end
