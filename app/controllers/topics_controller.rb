class TopicsController < ApplicationController
  before_action :authenticate_user!
  def index
    session[:return_to] = nil
  end
  def new
    @topic = Topic.new
  end
  def create
    if params[:topics] && params[:topics][:ids].present?
      current_user.topics.destroy_all
      params[:topics][:ids].each do |topic_id|
        topic = Topic.find(topic_id)
        current_user.topics << topic
      end
      redirect_to root_path
    end
  end
end