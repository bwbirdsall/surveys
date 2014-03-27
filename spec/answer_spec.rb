require 'spec_helper'

describe Answer do
  it { should belong_to :question }
  it { should validate_presence_of :answer }
  it { should validate_presence_of :answer_code }
  it { should ensure_length_of(:answer_code). is_equal_to(1) }
  it { should validate_uniqueness_of(:answer_code).scoped_to(:question_id) }
end
