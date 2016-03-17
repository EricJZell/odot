FactoryGirl.define do

  factory :user do
    first_name "John"
    last_name "Doe"
    sequence(:email) { |n| "user#{n}@odot.com" }
    password "treehouse1"
    password_confirmation "treehouse1"
  end

end
