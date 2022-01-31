class AddColumnToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :total_points, :integer
    add_column :orders, :avg_points, :integer
  end
end
