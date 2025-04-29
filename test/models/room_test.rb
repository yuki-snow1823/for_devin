require "test_helper"

class RoomTest < ActiveSupport::TestCase
  setup do
    @room = Room.create(status: 'waiting')
    @user1 = User.create(name: "ユーザー1", email: "user1@example.com", uid: "123", provider: "google_oauth2")
    @user2 = User.create(name: "ユーザー2", email: "user2@example.com", uid: "456", provider: "google_oauth2")
  end

  test "ルームが有効であること" do
    assert @room.valid?
  end

  test "full?メソッドが正しく動作すること" do
    assert_not @room.full?
    
    @room.players.create(user: @user1, is_ai: false)
    assert_not @room.full?
    
    @room.players.create(user: @user2, is_ai: false)
    assert @room.full?
  end

  test "opponent_ofメソッドが正しく動作すること" do
    player1 = @room.players.create(user: @user1, is_ai: false)
    player2 = @room.players.create(user: @user2, is_ai: false)
    
    assert_equal player2, @room.opponent_of(player1)
    assert_equal player1, @room.opponent_of(player2)
  end

  test "game_result_forメソッドが正しく動作すること - 人間がAIを正しく判定" do
    human_player = @room.players.create(user: @user1, is_ai: false)
    ai_player = @room.players.create(is_ai: true)
    
    human_player.update(guess: "ai")
    ai_player.update(guess: "human")
    
    assert_equal "勝ち", @room.game_result_for(human_player)
    assert_equal "負け", @room.game_result_for(ai_player)
  end

  test "game_result_forメソッドが正しく動作すること - 人間同士で正しく判定" do
    player1 = @room.players.create(user: @user1, is_ai: false)
    player2 = @room.players.create(user: @user2, is_ai: false)
    
    player1.update(guess: "human")
    player2.update(guess: "human")
    
    assert_equal "引き分け", @room.game_result_for(player1)
    assert_equal "引き分け", @room.game_result_for(player2)
  end
end
