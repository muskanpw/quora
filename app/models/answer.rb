class Answer < ApplicationRecord
  belongs_to :question  
  #has_many :up_votes, class_name: 'Vote'   , foreign_key: :up_vote_id
  #has_many :down_votes, class_name: 'Vote' , foreign_key: :down_vote_id
  has_many :votes 
  validates :ans_content, presence: true
  mount_uploader :photo, PictureUploader
  
  after_create :send_notification_user

  def up_votes
    self.votes.where(vote_type: Vote.vote_types[:upvote])
  end

  def down_votes
    self.votes.where(vote_type: Vote.vote_types[:downvote])
  end



  def send_notification_user
    UserMailer.answer_notification(self.question.user).deliver_now
  end
end
