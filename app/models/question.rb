class Question < ApplicationRecord
  # Associations
  has_and_belongs_to_many :topics
  belongs_to :user
  has_many :answers
  
  accepts_nested_attributes_for :answers
end
