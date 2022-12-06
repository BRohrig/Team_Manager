class PlayersController < ApplicationController
  def index
    if eligible_param[:eligible] == "true"
      @players = Player.eligible_sort
      @header = "Players Eligible for Trade:"
    else
      @players = Player.all
      @header = "Players"
    end
  end

  def show
    @player = Player.find(params[:id])
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    player = Player.find(params[:id])
    player.update(update_params)
    player.save
    redirect_to "/players/#{player.id}"
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to "/players"
  end

  private

  def update_params
    params.require(:player).permit(:name, :salary, :citizen, :trade_eligible, :contract_length_months)
  end

  def eligible_param
    params.permit(:eligible)
  end
end