class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    player = Player.find(params[:id])
    player.update({
      name: params[:player][:name],
      salary: params[:player][:salary],
      citizen: params[:player][:citizen],
      trade_eligible: params[:player][:trade_eligible],
      contract_length_months: params[:player][:contract_length_months]
    })
    player.save
    redirect_to "/players/#{player.id}"



  end
end