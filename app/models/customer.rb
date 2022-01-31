# = Schema Information
# Table name: customers

# id                :integer    not null, primary_key
# name              :string

class Customer < ApplicationRecord
    has_many :orders
    
    def self.total_points(customer_id)
        tot_points = 0
        customer = Customer.find_by_id(customer_id)
        if customer.present?
            customer.orders.each do |ord|
                tot_points += ord.total_points if ord.total_points.present?
            end
        end
        puts tot_points
        tot_points
    end

    def self.average_points(customer_id)
        customer = Customer.find_by_id(customer_id)
        avg_points = 0
        
        if customer.present?
            if customer.orders.length > 0
                cust_total_points_array = customer.orders.select(:total_points).map(&:total_points).compact
                avg_points = cust_total_points_array.sum / cust_total_points_array.size
                customer.update!(avg_points_per_order: avg_points)
            end
        end
        puts avg_points
    end
end
