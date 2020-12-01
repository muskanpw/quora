class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :confirmable, :lockable #, :timeoutable, :trackable and :omniauthable
  has_many :questions
  has_many :votes 
  has_and_belongs_to_many :topics
  mount_uploader :image, PictureUploader
  
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  
  devise :omniauthable, omniauth_providers: %i[facebook]

  enum status: [:pending, :approved, :rejected]


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.status = 'approved'
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
