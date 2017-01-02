class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :list, class_name: 'Todo', foreign_key: 'creator_id'
  has_many :todo


  has_many :created_teams, class_name: 'Team', foreign_key: 'creator_id'
  has_many :projects
  has_many :accesses
  has_many :view_projects, through: :accesses ,source: :project


  has_and_belongs_to_many :teams
end
