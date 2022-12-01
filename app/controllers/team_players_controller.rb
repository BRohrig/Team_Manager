class TeamPlayersController < ApplicationController
  def index
    @team = Team.find(params[:id])
    @players = @team.players
  end


end