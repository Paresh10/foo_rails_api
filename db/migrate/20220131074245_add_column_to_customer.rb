class AddColumnToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :avg_points_per_order, :integer
  end
end
