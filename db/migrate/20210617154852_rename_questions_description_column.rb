class RenameQuestionsDescriptionColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :questions, :description, :answer
  end
end
