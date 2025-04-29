require "test_helper"

class ResponseTest < ActiveSupport::TestCase
  setup do
    @room = Room.create(status: 'active')
    @user = User.create(name: "テストユーザー", email: "test@example.com", uid: "123", provider: "google_oauth2")
    @player = @room.players.create(user: @user, is_ai: false)
    @question = Question.create(content: "テスト質問")
  end

  test "回答が有効であること" do
    response = Response.new(player: @player, question: @question, answer_text: "テスト回答")
    assert response.valid?
  end

  test "プレイヤーが必須であること" do
    response = Response.new(question: @question, answer_text: "テスト回答")
    assert_not response.valid?
  end

  test "質問が必須であること" do
    response = Response.new(player: @player, answer_text: "テスト回答")
    assert_not response.valid?
  end

  test "回答テキストが存在すること" do
    response = Response.new(player: @player, question: @question)
    assert_not response.valid?
    
    response.answer_text = "テスト回答"
    assert response.valid?
  end
end
