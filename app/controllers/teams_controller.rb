class TeamsController < ApplicationController
  def index
    @teams = Team.all.created_order
  end

  def show
    @team = Team.find(params[:id])
    @player_count = @team.player_count
  end

  def new
  end

  def create
    team = Team.new(team_params)
    team.save
    redirect_to '/teams'
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    team = Team.find(params[:id])
    team.update(team_params)
    team.save
    redirect_to "/teams/#{team.id}"
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to "/teams"
  end

  private

  def team_params
    params.require(:team).permit(:name, :city, :owner, :title_holder, :titles_won)
  end
end