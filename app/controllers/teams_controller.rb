class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @player_count = @team.player_count
  end

  def new
  end

  def create
    team = Team.new({
      name: params[:team][:name],
      city: params[:team][:city],
      owner: params[:team][:owner],
      title_holder: params[:team][:title_holder],
      titles_won: params[:team][:titles_won]
    })
    team.save
    redirect_to '/teams'
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    team = Team.find(params[:id])
    team.update({
      name: params[:team][:name],
      city: params[:team][:city],
      owner: params[:team][:owner],
      title_holder: params[:team][:title_holder],
      titles_won: params[:team][:titles_won]
    })
    team.save
    redirect_to "/teams/#{team.id}"
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to "/teams"
  end

end