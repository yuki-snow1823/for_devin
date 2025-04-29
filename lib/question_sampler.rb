class QuestionSampler
  def self.sample(n)
    path = Rails.root.join('config/questions.yml')
    questions = YAML.load_file(path)["questions"]
    questions.shuffle.take(n).map { |q| Question.find_or_create_by(content: q) }
  end
end
