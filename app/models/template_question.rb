class TemplateQuestion < ApplicationRecord
  belongs_to :template
  belongs_to :question
  validates_uniqueness_of :question_id, :scope => :template_id
end
