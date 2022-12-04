class TeamPlayersController < ApplicationController
  def index
    @team = Team.find(params[:id])
    @players = @team.players
  end

  def new
    @team = Team.find(params[:id])
  end

  def create_player
    player = Player.new({
      name: params[:player][:name],
      salary: params[:player][:salary],
      citizen: params[:player][:citizen],
      trade_eligible: params[:player][:trade_eligible],
      contract_length_months: params[:player][:contract_length_months],
      team_id: params[:player][:team_id]
    })
    player.save

    redirect_to "/teams/#{player.team_id}/players"
  end

  def name_sort
    @team = Team.find(params[:id])
    extracted_team_id = @team.id
    @players = Player.sort_name

    render 'index'
  end

end