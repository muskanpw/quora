class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :question_title
      t.date :question_date
      t.belongs_to :user
      #t.belongs_to :topic

      t.timestamps
    end
  end
end
