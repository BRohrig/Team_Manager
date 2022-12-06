class TeamsController < ApplicationController
  def index
    if player_count_sort[:player_count] == "sort"
      @teams = team_sort
    else
      @teams = Team.all.created_order
    end
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

  def player_count_sort
    params.permit(:player_count)
  end

  def team_sort
    Team.all.sort_by do |team|
      team.player_count
    end.reverse
  end
end