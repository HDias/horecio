FactoryBot.define do
  factory :user do
    display_name { Faker::Name.name }
    username { Faker::Internet.unique.username }
    email { Faker::Internet.email }
    company { create(:company) }
  end
end
