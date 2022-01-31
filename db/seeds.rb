# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

data = JSON.parse(File.read(File.join(Rails.root, 'data', 'customers_and_orders.json')))

data['events'].each do |d|
    if d['action'] == "new_customer"
        Customer.create!({
            name: d['name'],
            created_at: d['timestamp']
    })
    else
        Order.create!({
            customer_id: Customer.find_by_name(d['customer']).id,
            amount: d['amount'].to_d,
            created_at: d['timestamp']
    })
    end
end
