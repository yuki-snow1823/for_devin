require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  test "質問が有効であること" do
    question = Question.new(content: "テスト質問")
    assert question.valid?
  end

  test "QuestionSamplerが正しく動作すること" do
    Question.create(content: "質問1")
    Question.create(content: "質問2")
    Question.create(content: "質問3")
    Question.create(content: "質問4")
    Question.create(content: "質問5")
    
    questions = QuestionSampler.sample(3)
    
    assert_equal 3, questions.length
    questions.each do |q|
      assert q.is_a?(Question)
      assert q.content.present?
    end
  end
end
