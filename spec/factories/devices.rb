
FactoryBot.define do
  timestamp = DateTime.parse(2.weeks.ago.to_s).to_time.strftime("%F %T")
  
  factory :device do
    name { Faker::Lorem.word }
    token 'xxx'
    last_request_at { timestamp }
  end
end
