FactoryBot.define do
  factory :subscription do
    title { Faker::Company.name }
    price { Faker::Number.decimal(l_digits: 2) }
    status { 1 }
    frequency { 1 }
  end
end
