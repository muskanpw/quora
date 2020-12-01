class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :confirmable, :lockable #, :timeoutable, :trackable and :omniauthable
  has_many :questions
  has_many :votes 
  has_and_belongs_to_many :topics
  mount_uploader :image, PictureUploader
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
    
end
