FactoryBot.define do
  timestamp = DateTime.parse(2.weeks.ago.to_s).to_time.strftime("%F %T")
  email = Faker::Internet.email
  
  factory :user do
    uid { email }
    name { Faker::Name.name }
    email { email }
    encrypted_password { User.new.send(:password_digest, 'secret123') }
    password { User.new.send(:password_digest, 'secret123') }
    provider 'email'
    created_at   { timestamp }
    updated_at   { timestamp }
  end
  
  factory :userx do
    uid { email }
    name { Faker::Name.name }
    email { email }
    encrypted_password { User.new.send(:password_digest, 'secret123') }
    password { User.new.send(:password_digest, 'secret123') }
    provider 'email'
    created_at   { timestamp }
    updated_at   { timestamp }
  end
end
