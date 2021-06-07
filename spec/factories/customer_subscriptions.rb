FactoryBot.define do
  factory :customer_subscription do
    customer { nil }
    subscription { nil }
    association :subscription
  end
end
