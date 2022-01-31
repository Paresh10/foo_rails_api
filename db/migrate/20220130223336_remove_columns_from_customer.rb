class RemoveColumnsFromCustomer < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :total_points
    remove_column :customers, :average_points
  end
end
