class HomeController < ApplicationController
  before_action :redirect_to_interest_page
  
  def index
    @answer = Answer.new
    @vote = Vote.new
    @questions = Question.includes(:topics, :answers, answers: :votes).where('topics.id IN (?)', current_user.topics.ids).references(:topic)
    
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
end
