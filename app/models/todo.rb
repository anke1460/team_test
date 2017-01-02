class Todo < ApplicationRecord
  belongs_to :creator,  class_name: 'User', foreign_key: "creator_id"
  belongs_to :user, optional: true


  has_many :comments
  belongs_to :project


  after_create :activity_on_create

  after_update :activity_on_update

  before_destroy :activity_on_destroy

  scope :works, -> { where(is_delete: false) }


  private

  def activity_on_create
    Event.create(sender: self, owner: self.creator, receiver: self.project, key: (self.class.name.underscore.gsub('/', '_') + "." + 'create'))
  end

  def activity_on_update
    Event.create(sender: self, owner: self.creator, receiver: self.project, key: (self.class.name.underscore.gsub('/', '_') + "." + 'update'), parameters: self.changes)
  end

  def activity_on_destroy
    Event.create(sender: self, owner: self.creator, receiver: self.project, key: (self.class.name.underscore.gsub('/', '_') + "." + 'detroy'))
  end

end
