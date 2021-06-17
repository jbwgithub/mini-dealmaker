class Template < ApplicationRecord
  has_many :template_questions
  has_many :questions, through: :template_questions
  validates :name, presence: true,
                      uniqueness: { case_sensitive: false },
                      length: { minimum: 3, maximum: 25 }
end
