# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times {Customer.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, address: Faker::Address.full_address)}

Customer.all.each do |customer|
  3.times do
    sub = Subscription.create(title: Faker::Company.name, price: Faker::Number.decimal(l_digits: 2), status: Faker::Number.within(range: 0..1), frequency: Faker::Number.within(range: 7..30))
    2.times do
      tea = Tea.create(title: Faker::Tea.variety, description: Faker::Tea.type, brew_time: Faker::Number.within(range: 60..180), temperature: Faker::Number.within(range: 150..180))
      SubscriptionTea.create(subscription: sub, tea: tea)
    end
    CustomerSubscription.create(customer: customer, subscription: sub)
  end
end
