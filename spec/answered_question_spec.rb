require 'spec_helper'

describe AnsweredQuestion do
  it { should belong_to :taken_survey}
  it { should belong_to :answer}
  it { should belong_to :question}
end
