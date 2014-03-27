class AddAnswerCode < ActiveRecord::Migration
  def change
    add_column :answers, :answer_code, :string
  end
end
