FactoryGirl.define do
  factory :user do
    email "test@gmail.com"
    password "password"
    password_confirmation "password"
  end

  factory :article do
    title "Title"
    text "Bla bla text"
    user_id 1
  end
end