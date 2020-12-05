class User < ApplicationRecord
  # Associations
  has_many :questions
  has_many :votes 
  has_and_belongs_to_many :topics
  has_one :image, as: :imageable
  
  accepts_nested_attributes_for :image, allow_destroy: true
  accepts_nested_attributes_for :topics, allow_destroy: true

   # Include default devise modules. Others available are:
  devise :confirmable, :lockable #, :timeoutable, :trackable and :omniauthable

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
