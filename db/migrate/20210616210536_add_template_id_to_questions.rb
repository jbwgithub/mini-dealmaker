class AddTemplateIdToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :template_id, :int
  end
end
