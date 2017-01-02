class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :todo

  after_create :activity_on_create

  private

  def activity_on_create
    Event.create(sender: self, owner: self.user, receiver: self.todo.project, key: (self.class.name.underscore.gsub('/', '_') + "." + 'create'))
  end
end
