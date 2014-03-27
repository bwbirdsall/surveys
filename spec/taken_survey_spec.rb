require 'spec_helper'

describe TakenSurvey do
  it { should belong_to :survey}
  it { should have_many :answered_questions}
  it { should validate_presence_of :taker_name}
end
