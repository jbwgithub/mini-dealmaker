class FixQuestionsColumnAgain < ActiveRecord::Migration[6.1]
  def change
    rename_column :questions, :question, :ask
  end
end
