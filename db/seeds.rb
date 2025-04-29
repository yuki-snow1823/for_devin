puts "質問データを読み込み中..."
questions_data = YAML.load_file(Rails.root.join('config/questions.yml'))["questions"]
questions_data.each do |content|
  Question.find_or_create_by!(content: content)
end
puts "#{Question.count}件の質問データを読み込みました"

puts "テストユーザーを作成中..."
user1 = User.find_or_create_by!(email: "user1@example.com") do |u|
  u.name = "テストユーザー1"
  u.uid = "test_uid_1"
  u.provider = "google_oauth2"
end

user2 = User.find_or_create_by!(email: "user2@example.com") do |u|
  u.name = "テストユーザー2"
  u.uid = "test_uid_2"
  u.provider = "google_oauth2"
end
puts "テストユーザーを作成しました"

puts "AIプレイヤーとのマッチングをシミュレート中..."
room = Room.create!(status: "active")
human_player = room.players.create!(user: user1, is_ai: false)
ai_player = room.players.create!(is_ai: true)

questions = QuestionSampler.sample(3)

puts "人間プレイヤーの回答をシミュレート中..."
Response.create!(player: human_player, question: questions[0], answer_text: "カレーライスです。")
Response.create!(player: human_player, question: questions[1], answer_text: "「君の名は。」を見ました。")
Response.create!(player: human_player, question: questions[2], answer_text: "公園でランニングしています。")

puts "AIプレイヤーの回答を生成中..."
require Rails.root.join('lib/ai_responder')
AiResponder.answer_questions_for_player(ai_player)

puts "シードデータの作成が完了しました"
