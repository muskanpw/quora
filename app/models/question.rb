class Question < ApplicationRecord
  has_and_belongs_to_many :topics
  belongs_to :user
  has_many :answers
  
end
