class QuestionsController < ApplicationController  
  def index
    @questions = current_user.questions
  end
  def show
    @question= Question.find(params[:id])
  end

  def new
    @question = Question.new
  end
  
   def edit
    @question = Question.find(params[:id])
    
  end

  def create
    @question=current_user.questions.new(question_params)
     if @question.save
      flash[:notice] = 'Question created successfully.'
      if params[:topics][:ids].present?
        params[:topics][:ids].each do |topic_id|
          topic = Topic.find(topic_id)
          @question.topics << topic
        end
      end
      redirect_to questions_path
    else
      render :new
    end
  end
  
  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      @question.topics.destroy_all
      flash[:notice] = 'Question updated successfully.'
      if params[:topics].present? && params[:topics][:ids].present?
        params[:topics][:ids].each do |topic_id|
          topic = Topic.find(topic_id)
          @question.topics << topic
        end
      end
      redirect_to edit_question_path(@question)
    else
      render "edit"
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  private
    def question_params
      params.require(:question).permit(:question_title,:question_date)
    end
end
