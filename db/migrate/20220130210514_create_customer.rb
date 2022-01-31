class CreateCustomer < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :total_points
      t.integer :avg_points_per_order
      t.timestamps
    end
  end
end
