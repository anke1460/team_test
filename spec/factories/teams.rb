FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "name#{n}"}
    association :creator, factory: :user
  end
end