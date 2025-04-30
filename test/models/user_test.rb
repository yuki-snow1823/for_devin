require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "ユーザーが有効であること" do
    user = User.new(
      name: "テストユーザー", 
      email: "test_valid@example.com", 
      uid: "123456", 
      provider: "google_oauth2",
      password: "password123",
      password_confirmation: "password123"
    )
    assert user.valid?
  end

  test "Deviseによる認証が機能すること" do
    user = User.create(
      name: "テストユーザー3", 
      email: "test_auth@example.com", 
      uid: "123456", 
      provider: "google_oauth2",
      password: "password123",
      password_confirmation: "password123"
    )
    
    assert user.valid_password?("password123")
  end
end
