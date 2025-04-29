require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "ユーザーが有効であること" do
    user = User.new(name: "テストユーザー", email: "test@example.com", uid: "123456", provider: "google_oauth2")
    assert user.valid?
  end

  test "find_or_create_by_authメソッドが正しく動作すること" do
    auth = {
      uid: "123456",
      provider: "google_oauth2",
      info: {
        name: "テストユーザー",
        email: "test@example.com"
      }
    }
    
    user = User.find_or_create_by_auth(auth)
    assert_equal "テストユーザー", user.name
    assert_equal "test@example.com", user.email
    assert_equal "123456", user.uid
    assert_equal "google_oauth2", user.provider
  end
end
