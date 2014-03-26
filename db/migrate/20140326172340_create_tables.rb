class CreateTables < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.column :name, :string

      t.timestamps
    end
    create_table :questions do |t|
      t.column :question, :string
      t.belongs_to :survey
      t.timestamps
    end
    create_table :answers do |t|
      t.column :answer, :string
      t.belongs_to :question
      t.timestamps
    end
    create_table :taken_surveys do |t|
      t.column :taker_name, :string
      t.belongs_to :survey
      t.timestamps
    end
    create_table :answered_questions do |t|
      t.belongs_to :taken_survey
      t.belongs_to :question
      t.belongs_to :answer
      t.timestamps
    end
  end
end
