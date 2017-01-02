FactoryGirl.define do
  factory :todo do
    sequence(:name) { |n| "content#{n}"}
    finish_at 10.days.from_now
    state 0
    is_delete false
    association :user
    association :creator, factory: :user
    association :project
  end
end