class VotesController < ApplicationController

  def upvote
    @answer = Answer.find(params[:answer_id])
    if params[:dislike] == 'true'
      vote =  @answer.votes.where(user_id: current_user.id, vote_type:'upvote').first
      vote.destroy if vote.present?
    else
      @vote = @answer.votes.new(user_id: current_user.id, vote_type: 'upvote')
      @vote.save
    end
    respond_to do |format|
      format.html
      format.js{}
    end
  end

  def downvote
    @answer = Answer.find(params[:answer_id])
    if params[:undislike] == 'true'
      vote = @answer.votes.where(user_id: current_user.id, vote_type: 'downvote').first
      vote.destroy if vote.present?
    else
      @vote = @answer.votes.new(user_id: current_user.id, vote_type: 'downvote')
      @vote.save
    end
    respond_to do |format|
      format.html
      format.js{}
    end
  end
end





















