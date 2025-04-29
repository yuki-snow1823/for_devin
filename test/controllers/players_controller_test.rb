require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(name: "テストユーザー", email: "test@example.com", uid: "123456", provider: "google_oauth2")
    @room = Room.create(status: "active")
    @player = @room.players.create(user: @user, is_ai: false)
  end

  test "should update player guess" do
    patch player_path(@player), params: { guess: "ai" }
    assert_redirected_to room_path(@room)
    @player.reload
    assert_equal "ai", @player.guess
  end
end
