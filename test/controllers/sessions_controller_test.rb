require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456',
      info: {
        name: 'テストユーザー',
        email: 'test@example.com'
      }
    })
  end

  test "should create user and session on successful authentication" do
    assert_difference('User.count', 1) do
      get '/auth/google_oauth2/callback'
      assert_redirected_to root_path
      assert session[:user_id].present?
    end
  end

  test "should destroy session on logout" do
    user = User.create(name: 'テストユーザー', email: 'test@example.com', uid: '123456', provider: 'google_oauth2')
    post '/auth/google_oauth2/callback'
    
    delete logout_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end
end
