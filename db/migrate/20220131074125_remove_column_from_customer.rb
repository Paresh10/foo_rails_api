class RemoveColumnFromCustomer < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :avg_points
  end
end
