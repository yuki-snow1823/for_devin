class Room < ApplicationRecord
  has_many :players, dependent: :destroy
  
  def full?
    players.count >= 2
  end
  
  def opponent_of(player)
    players.where.not(id: player.id).first
  end
  
  def game_result_for(player)
    return nil unless players.all? { |p| p.guess.present? }
    
    opponent = opponent_of(player)
    
    if player.is_ai && opponent.guess == "ai"
      "負け" # 人間が正しく判定
    elsif !player.is_ai && opponent.is_ai && player.guess == "ai"
      "勝ち" # 人間がAIを正しく判定
    elsif !player.is_ai && !opponent.is_ai && player.guess == "human" && opponent.guess == "human"
      "引き分け" # 人間同士で正しく判定
    else
      "負け" # その他のケース
    end
  end
end
