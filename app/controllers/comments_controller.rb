class CommentsController < ApplicationController
  before_action :authenticate_user!


  def index
  
  end

  def create
    @project = current_user.view_projects.find(params[:project_id])
    @todo = @project.todos.find(params[:todo_id])
    comment = Comment.new(content:params[:comment][:content], todo: @todo)
    comment.user = current_user
    comment.save
    
    redirect_to project_todo_url(@project, @todo)
  end

end
