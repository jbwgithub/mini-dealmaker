class QuestionsController < ApplicationController
  before_action :set_question, except: [:index]

  def index
    @questions = Question.all
  end

  def update
    @question.update(question_params)
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:id, :title, :description)
  end

end
