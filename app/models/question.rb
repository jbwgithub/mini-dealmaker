class Question < ApplicationRecord
  has_many :template_questions
  has_many :templates, through: :template_questions
  validates :ask, presence: true, length: {minimum: 3, maximum: 100}
end
