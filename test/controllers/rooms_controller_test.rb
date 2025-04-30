require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(
      name: "テストユーザー", 
      email: "test_room@example.com", 
      uid: "123456", 
      provider: "google_oauth2",
      password: "password123",
      password_confirmation: "password123"
    )
    @room = Room.create(status: "active")
    @player = @room.players.create(user: @user, is_ai: false)
    
    sign_in @user
  end

  test "should get index" do
    get root_path
    assert_response :success
  end

  test "should create room" do
    post rooms_path, params: {}
    assert_redirected_to room_path(Room.last)
  end

  test "should show room" do
    get room_path(@room)
    assert_response :success
  end

  test "should show questions in room" do
    get room_path(@room)
    assert_response :success
    assert_not_nil assigns(:questions)
  end
end
