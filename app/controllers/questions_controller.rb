class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def new
    @question = Question.new
  end

  def index
    @questions = Question.all
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "Question was saved successfully." # For flash display. Common flash keys: notice, alert
      redirect_to questions_path
    else
      render 'new'
    end
  end

  def update
    @question.update(question_params)
  end

  def destroy
    @question.destroy
    flash[:notice] = "Question was successfully deleted."
    redirect_to questions_path
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:id, :title, :description, template_ids: [])
  end

end
