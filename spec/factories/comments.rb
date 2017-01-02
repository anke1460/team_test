FactoryGirl.define do
  factory :comment do
    sequence(:content) { |n| "content#{n}"}
    association :user
    association :todo
  end
end