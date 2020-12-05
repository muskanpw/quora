class HomeController < ApplicationController
  before_action :redirect_to_interest_page
  before_action :check_account_status, only: [:index]
  
  def index
    @answer = Answer.new
    #@image = @answer.images.build
    @vote = Vote.new
    @questions = Question.includes(:topics, :answers, answers: :votes).where('topics.id IN (?)', current_user&.topics&.ids).references(:topic)
    session[:status_return_to] = nil
  end

  def account_not_approved
  end

  private
    def redirect_to_interest_page
      if current_user && current_user.topics.blank?
        session[:return_to] = topics_path
        if current_user.present? && session[:return_to].present?
          redirect_to session[:return_to]
        end 
      end
    end

    def check_account_status
      if current_user.present? && ( current_user.pending? || current_user.rejected? )
        flash[:notice] = "Your account is #{current_user.status}. please contact to admin"
        sign_out current_user
        redirect_to account_not_approved_home_index_path and return 
      end
    end
end
