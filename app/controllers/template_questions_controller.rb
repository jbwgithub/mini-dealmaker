class TemplateQuestionsController < ApplicationController

  def new
    @template_question = TemplateQuestion.new
  end

  def create
    @template_question = TemplateQuestion.new(template_question_params)
    @template_question.save
  end

  private

  def template_question_params
    params.require(:template_question).permit(:question_id, :template_id)
  end

end
