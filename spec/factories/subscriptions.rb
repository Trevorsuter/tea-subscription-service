FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { "9.99" }
    status { 1 }
    frequency { 1 }
  end
end
