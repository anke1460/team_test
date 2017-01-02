class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_team = current_user.teams.find(params[:team_id])
    @projects = @current_team.projects

    @events = Event.where("receiver_type ='Project' AND receiver_id in (?)", @projects.pluck(:id)).order("id desc").limit(50)
    
    if params[:_id]
      @events = @events.where("id < ?", params[:_id])
    end

  end
end
