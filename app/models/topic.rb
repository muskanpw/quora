class Topic < ApplicationRecord
  # Associations
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :users
end
