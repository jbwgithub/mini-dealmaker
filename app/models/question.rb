class Question < ApplicationRecord
  has_many :template_questions
  has_many :templates, through: :template_questions, dependent: :destroy # To remove question from many-many table after deleting a questions that was in templates
  validates :ask, presence: true, length: {minimum: 3, maximum: 100}
end
