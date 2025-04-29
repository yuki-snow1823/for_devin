require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  setup do
    @room = Room.create(status: 'active')
    @user = User.create(name: "テストユーザー", email: "test@example.com", uid: "123", provider: "google_oauth2")
    @player = @room.players.create(user: @user, is_ai: false)
    @question1 = Question.create(content: "質問1")
    @question2 = Question.create(content: "質問2")
    @question3 = Question.create(content: "質問3")
  end

  test "プレイヤーが有効であること" do
    assert @player.valid?
  end

  test "AIプレイヤーが有効であること" do
    ai_player = @room.players.create(is_ai: true)
    assert ai_player.valid?
  end

  test "answered_all_questions?メソッドが正しく動作すること" do
    assert_not @player.answered_all_questions?
    
    Response.create(player: @player, question: @question1, answer_text: "回答1")
    assert_not @player.answered_all_questions?
    
    Response.create(player: @player, question: @question2, answer_text: "回答2")
    assert_not @player.answered_all_questions?
    
    Response.create(player: @player, question: @question3, answer_text: "回答3")
    assert @player.answered_all_questions?
  end

  test "response_forメソッドが正しく動作すること" do
    response = Response.create(player: @player, question: @question1, answer_text: "回答1")
    
    assert_equal response, @player.response_for(@question1)
    assert_nil @player.response_for(@question2)
  end
end
