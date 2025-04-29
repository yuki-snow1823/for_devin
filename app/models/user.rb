class User < ApplicationRecord
  has_many :players
  
  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(uid: auth[:uid], provider: auth[:provider]) do |u|
      u.name = auth[:info][:name]
      u.email = auth[:info][:email]
    end
    user
  end
end
