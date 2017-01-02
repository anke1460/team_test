class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects =current_user.view_projects.where(team_id: params[:team_id])
    @current_team = current_user.teams.find(params[:team_id])
    @teams_list = current_user.teams.where.not(id: params[:id])
  end

  def show
     @team = current_user.created_teams.find(params[:team_id])
  end

  def new
    @project = Project.new
    @current_team = current_user.teams.find(params[:team_id])
  end

  def edit
    @projects = current_user.view_projects.find(params[:id])
    @team = current_user.created_teams.find(params[:team_id])
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.team = current_user.created_teams.find(params[:team_id])
    params[:user].each do |u|
      @project.accesses.build({user_id: u})
    end
   
    respond_to do |format|
      if @project.save!
        format.html { redirect_to team_projects_path(@project.team), notice: 'Project was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to team_projects_path(@project.team), notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
      @current_team = current_user.teams.find(params[:team_id])
    end

    def project_params
      params.require(:project).permit(:name)
    end
end
