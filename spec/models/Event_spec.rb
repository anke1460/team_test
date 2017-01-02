require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { create :user }

  describe 'generate event' do
    it "should can generate an event when created a comment" do
      comment = create(:comment, user: user)
      event = Event.find_by_sender_type_and_sender_id('Comment', comment.id)

      expect(event.id).not_to eq nil
      expect(event.owner_id).to eq user.id
    end

    it "should can generate an event when todo" do
      todo = create(:todo)

      event = Event.find_by_sender_type_and_sender_id('Todo', todo.id)
      expect(event.id).not_to eq nil
    end

    it "should can generate an event when update a todo" do
      todo = create(:todo)

      todo.update(finish_at: 1.days.from_now)

      event = Event.find_by_sender_type_and_sender_id_and_key('Todo', todo.id, 'todo.update')
      expect(event.id).not_to eq nil
    end

    it "should can generate an event when destroy a todo" do
      todo = create(:todo)

      todo.update(is_delete: true)

      event = Event.find_by_sender_type_and_sender_id_and_key('Todo', todo.id, 'todo.update')
      expect(event.id).not_to eq nil
    end


  end


end