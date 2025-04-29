class Player < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room
  has_many :responses, dependent: :destroy
  
  def answered_all_questions?
    responses.count >= 3
  end
  
  def response_for(question)
    responses.find_by(question: question)
  end
  
  def name
    is_ai? ? "AIプレイヤー" : user&.name || "ゲスト"
  end
end
