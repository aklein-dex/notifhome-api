
FactoryBot.define do
  factory :notification do
    message { Faker::Lorem.word }
  end
end
