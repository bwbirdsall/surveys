require 'spec_helper'

describe Survey do
  it { should have_many :questions }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of :name }

  it 'should create an instance of Survey' do
    survey = Survey.new :name => "Gerald"
    survey.should be_an_instance_of Survey
  end

end
