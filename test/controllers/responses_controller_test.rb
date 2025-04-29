require "test_helper"

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(name: "テストユーザー", email: "test@example.com", uid: "123456", provider: "google_oauth2")
    @room = Room.create(status: "active")
    @player = @room.players.create(user: @user, is_ai: false)
    @question = Question.create(content: "テスト質問")
  end

  test "should create response" do
    assert_difference('Response.count') do
      post responses_path, params: { 
        player_id: @player.id, 
        question_id: @question.id, 
        answer_text: "テスト回答" 
      }
    end
    assert_redirected_to room_path(@room)
  end
end
