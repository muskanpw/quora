class AnswersController < ApplicationController
  before_action :authenticate_user!
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answers = @question.answers
    respond_to do |format|
      if @answer.save
        format.html {redirect_to root_path}
        format.js{}
      else
        format.html {redirect_to root_path}
        format.js{}
      end
    end
  end
  

  private
    def answer_params
      params.require(:answer).permit(:ans_content, images_attributes:[:image])
    end
end
