class Vote < ApplicationRecord
  # validations
  validates_uniqueness_of :user_id, scope: [:vote_type, :answer_id]

  # Associations
  belongs_to :answer
  belongs_to :user
  
  enum vote_type: [:upvote, :downvote]
  
end
