class Survey < ActiveRecord::Base
  has_many :questions
  has_many :taken_surveys
  validates :name, :presence => true, :uniqueness => true
end
