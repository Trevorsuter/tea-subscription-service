class CreateSubscriptionCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_customers do |t|
      t.references :customer, foreign_key: true
      t.references :subscription, foreign_key: true
    end
  end
end
