# = Schema Information
# Table name: customers

# id                       :integer    not null, primary_key
# name                     :string
# total_points             :integer
# avg_points_per_order     :integer

class Customer < ApplicationRecord
    has_many :orders
    
    def customer_total_points
        tot_points = 0
        if self.orders.length > 0
            self.orders.each do |ord|
                tot_points += ord.rewards if ord.rewards.present?
            end
            self.update!(total_points: tot_points)
        end
        tot_points
    end

    def average_points
        avg_points = 0
        if self.orders.length > 0
            cust_rewards_array = self.orders.select(:rewards).map(&:rewards).compact
            avg_points = cust_rewards_array.sum / cust_rewards_array.size
            self.update!(avg_points_per_order: avg_points)
        end
        avg_points
    end
end
