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
    end
end
