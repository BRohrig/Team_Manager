class TeamPlayersController < ApplicationController
  
  def index
    @team = Team.find(params[:id])
    if sort_params[:sort] == "true"
      @players = @team.players.sort_name
    elsif salary_param[:salary_filter] != nil
      @players = @team.players.salary_filter(salary_param[:salary_filter])
    else
      @players = @team.players
    end
  end

  def new
    @team = Team.find(params[:id])
  end

  def create_player
    player = Player.new(create_params)
    player.save

    redirect_to "/teams/#{player.team_id}/players"
  end

  private

  def sort_params
    params.permit(:sort)
  end

  def create_params
    params.require(:player).permit(:name, :salary, :citizen, :trade_eligible, :contract_length_months, :team_id)
  end

  def salary_param
    params.permit(:salary_filter)
  end
end