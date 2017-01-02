FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "name#{n}"}
    association :team
    association :user
  end
end