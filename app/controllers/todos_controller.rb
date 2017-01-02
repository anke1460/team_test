class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  def index
    @todos = Todo.all
  end

  def show
    @project = current_user.projects.find(params[:project_id])
    @current_team = @project.team
    @comment = Comment.new
  end

  def new
    @todo = Todo.new
    @project = current_user.projects.find(params[:project_id])
    @current_team = @project.team
  end

  def edit
  end

  def create
    project = current_user.projects.find(params[:project_id])
    @todo = Todo.new(todo_params)
    @todo.project = project
    @todo.creator = current_user

    @todo.user = project.members.find(params[:user].first) if params[:user]
    

    respond_to do |format|
      if @todo.save!
        format.html { redirect_to team_project_url(project.team, project), notice: 'Todo was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    project = current_user.projects.find(params[:project_id])
    @todo = project.todos.find(params[:id])
    @todo.user = project.members.find_by_id(params[:todo][:user_id])
    respond_to do |format|

      if @todo.update(todo_params)
        format.html { redirect_to team_project_url(project.team, params[:project_id]), notice: 'Todo was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    project = current_user.projects.find(params[:project_id])
    @todo = project.todos.find(params[:id])
    @todo.update(is_delete: true)
    respond_to do |format|
      format.html { redirect_to team_project_url(project.team, params[:project_id]), notice: 'Todo was successfully destroyed.' }
    end
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:name, :state, :finish_at)
    end
end
