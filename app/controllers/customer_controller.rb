class CustomerController < ApplicationController

    def customers_report
        data = []
        Customer.all.order('total_points desc Nulls last').each do |cust|
            if cust['total_points'].present?
                data << {
                    name: cust['name'],
                    total_points: cust['total_points'],
                    avg_points: cust['avg_points_per_order'],
                    msg: "#{cust['name']}: #{cust['total_points']} points with #{cust['avg_points_per_order']} points per order."
                }
            else
                data << {
                    name: cust['name'],
                    total_points: 0,
                    avg_points: 0,
                    msg: "#{cust['name']}: No Orders"
                }
            end
        end
        render json: data
    end
end