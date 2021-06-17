class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  def index
    @templates = Template.all
  end

  def show

  end

  def destroy
    @template.destroy
    flash[:notice] = "Template was successfully deleted."
    redirect_to templates_path
  end

  private

  def set_template
    @template = Template.find(params[:id])
  end

end
