class ResponsesController < ApplicationController
  def create
    Response.create!(
      player_id: params[:player_id],
      question_id: params[:question_id],
      answer_text: params[:answer_text]
    )
    redirect_to room_path(Player.find(params[:player_id]).room)
  end
end
