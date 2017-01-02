require 'rails_helper'

describe CommentsController, type: :controller do

  describe "create comment" do
    it 'should create comment' do
      user = create :user
      project = create :project, user: user
      project.members << user
      project.save
      todo = create :todo, project: project

      sign_in user
      post :create, params: { project_id: project.id, todo_id: todo.id, comment: {content: 'hello'}}
      expect(response).to redirect_to(project_todo_url(project, todo))
    end
  end
end