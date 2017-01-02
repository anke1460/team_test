class Event < ApplicationRecord
  belongs_to :sender, polymorphic: true
  belongs_to :owner, polymorphic: true
  belongs_to :receiver, polymorphic: true


  serialize :parameters
end
