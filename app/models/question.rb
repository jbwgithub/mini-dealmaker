class Question < ApplicationRecord
  has_many :template_questions
  has_many :templates, through: :template_questions
  validates :title, presence: true, length: {minimum: 3, maximum: 100}
  validates :description, presence: true, length: {minimum: 5, maximum: 300}
end
