class CreateOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.bigint :customer_id
      t.decimal :amount
      t.timestamps
    end
    add_index :orders, [:customer_id]
  end
end
