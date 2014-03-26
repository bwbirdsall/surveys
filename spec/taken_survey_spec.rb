require 'spec_helper'

describe TakenSurvey do
  it { should belong_to :survey}
  it { should have_many :answered_questions}
end
