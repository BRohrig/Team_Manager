class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  

  # def new
  # end

  # def create
  #   team = Team.new({
  #     name: params[:team][:name],
  #     city: params[:team][:city],
  #     owner: params[:team][:owner],
  #     title_holder: params[:team][:title_holder],
  #     titles_won: params[:team][:titles_won]
  #   })
  #   team.save
  #   redirect_to '/teams'
  # end

end