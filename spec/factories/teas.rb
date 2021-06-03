FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    brew_time { 1 }
    temperature { 1 }
  end
end
