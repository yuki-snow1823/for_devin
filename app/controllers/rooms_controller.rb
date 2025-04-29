class RoomsController < ApplicationController
  def index
    @room = Room.where(status: 'waiting').first_or_create
    
    if current_user
      @player = @room.players.create(user: current_user, is_ai: false)
      
      if !@room.full?
        @room.players.create(is_ai: true)
      end
      
      if @room.players.count == 2
        @room.update(status: 'active')
      end
      
      redirect_to room_path(@room)
    end
  end

  def show
    @room = Room.find(params[:id])
    @questions = QuestionSampler.sample(3)
    
    if @room.players.where(is_ai: true).exists?
      ai_player = @room.players.find_by(is_ai: true)
      @questions.each do |question|
        unless ai_player.response_for(question)
          ai_answers = [
            "私はその質問に対する答えを考えています...",
            "それは難しい質問ですね。考えさせてください。",
            "興味深い質問です。私の経験では...",
            "その質問には様々な観点から答えられますね。"
          ]
          Response.create(
            player: ai_player,
            question: question,
            answer_text: ai_answers.sample
          )
        end
      end
    end
  end

  def create
    @room = Room.create(status: 'waiting')
    redirect_to room_path(@room)
  end
end
