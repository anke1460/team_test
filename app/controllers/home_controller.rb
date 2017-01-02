class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    redirect_to team_projects_url(current_user.teams.first)
  end
end
