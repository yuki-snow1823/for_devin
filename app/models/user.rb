class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :players
  
  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(uid: auth[:uid], provider: auth[:provider]) do |u|
      u.name = auth[:info][:name]
      u.email = auth[:info][:email]
    end
    user
  end
end
