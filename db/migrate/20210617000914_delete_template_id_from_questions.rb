class DeleteTemplateIdFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :template_id, :int
  end
end
