FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :article do
    association :user, factory: :user, strategy: :build
    title "Title"
    text "Bla bla text"
  end

  factory :comment do
    association :article
    commenter "Good"
    body "Not bad"
  end
end