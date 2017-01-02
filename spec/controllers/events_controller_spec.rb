require 'rails_helper'

describe EventsController, type: :controller do
  let(:user) { create :user}
  let(:team) { create :team, creator: user}

  describe 'visit view' do
    it "should visit owner teams's events" do
      team.users << user
      team.save
      sign_in user
      get :index, params: {team_id: team.id}
      expect(response).to be_success
    end

    it "should can not visit other teams's events" do
      sign_in user
      get :index, params: {team_id: team.id}
      expect(response).not_to be_success
    end

  
    it "should can get teams's events" do
      team.users << user
      team.save
      project = create(:project, team: team, user: user)
      create(:todo, user: user, project: project)

      sign_in user
      get :index, xhr: true, params: {team_id: team.id}

      expect(assigns[:events].count).to eq 1
      expect(response).to render_template(:index)

      get :index, xhr: true, params: {team_id: team.id, _id: 0}
      expect(assigns[:events].count).to eq 0


    end

  end
end