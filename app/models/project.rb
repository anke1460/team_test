class Project < ApplicationRecord
  belongs_to :team
  belongs_to :user
  has_many :accesses, dependent: :destroy

  has_many :todos

  has_many :events, as: :receiver

  has_many :members, through: :accesses, source: :user


end
