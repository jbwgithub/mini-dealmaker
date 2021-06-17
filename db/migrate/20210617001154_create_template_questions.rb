class CreateTemplateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :template_questions do |t|
      t.integer :template_id
      t.integer :question_id
    end
  end
end
