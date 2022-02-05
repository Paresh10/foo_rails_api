class CustomerController < ApplicationController

    def customers_report
        data = []
        Customer.all.order('total_points desc Nulls last').each do |cust|
            data << {
                name: cust['name'],
                total_points: cust.customer_total_points,
                avg_points: cust.average_points,
                msg: cust['total_points'].present? ? "#{cust['name']}: #{cust['total_points']} points with #{cust['avg_points_per_order']} points per order." : "#{cust['name']}: No Orders"
            }
        end
        render json: data
    end
end