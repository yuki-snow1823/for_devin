class PlayersController < ApplicationController
  def update
    player = Player.find(params[:id])
    player.update(guess: params[:guess])
    redirect_to room_path(player.room)
  end
end
