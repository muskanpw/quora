class Answer < ApplicationRecord
  # validations
  validates :ans_content, presence: true
  
  # Associations
  belongs_to :question  
  has_many :votes 
  has_many :images, as: :imageable#, inverse_of: :image
  
  accepts_nested_attributes_for :images, allow_destroy: true
  
  # Callbacks
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
