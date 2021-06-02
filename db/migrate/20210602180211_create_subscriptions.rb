class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.decimal :price, precision: 10, scale: 2
      t.integer :status
      t.integer :frequency

      t.timestamps
    end
  end
end
