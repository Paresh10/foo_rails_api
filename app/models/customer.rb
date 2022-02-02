# = Schema Information
# Table name: customers

# id                       :integer    not null, primary_key
# name                     :string
# total_points             :integer
# avg_points_per_order     :integer

class Customer < ApplicationRecord
    has_many :orders
    
    def self.customer_total_points(customer_id)
        tot_points = 0
        customer = Customer.find_by_id(customer_id)
        if customer.present?
            if customer.orders.length > 0
                customer.orders.each do |ord|
                    tot_points += ord.rewards if ord.rewards.present?
                end
                customer.update!(total_points: tot_points)
            end
        end
        tot_points
    end

    def self.average_points(customer_id)
        customer = Customer.find_by_id(customer_id)
        avg_points = 0

        if customer.present?
            if customer.orders.length > 0
                cust_rewards_array = customer.orders.select(:rewards).map(&:rewards).compact
                avg_points = cust_rewards_array.sum / cust_rewards_array.size
                customer.update!(avg_points_per_order: avg_points)
            end
        end
        avg_points
    end
end
