require 'spec_helper'

describe Question do
  it { should belong_to :survey}
  it { should validate_presence_of :question}
  it { should ensure_length_of(:question). is_at_least (10)}
end
