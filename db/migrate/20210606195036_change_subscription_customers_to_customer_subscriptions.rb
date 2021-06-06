class ChangeSubscriptionCustomersToCustomerSubscriptions < ActiveRecord::Migration[5.2]
  def change
    rename_table :subscription_customers, :customer_subscriptions
  end
end
