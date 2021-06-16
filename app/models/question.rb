class Question < ApplicationRecord
  belongs_to :template, optional: true
  validates :title, presence: true, length: {minimum: 6, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
end
