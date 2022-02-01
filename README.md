# README

Fooda Rails Api

* Ruby version
* 2.7.2


* How to run the app
* Please clone this repo and cd into it.
* Run `bundle install` which will install all the dependencies being used in this app from Gemfile
* Run rake db:dreate which will create the database in your local development env
* Run rake db:migrate which will run the migration files
* Run rake db:seed which will seed the database from db/seeds.rb

* What to expect
* This api provides the status on customer rewards points based on their purchasing history.
* Use your console. You can run bin/raiils c or rails c to open the development env in console.
* Now we want to run through our code and and get the results.

* run `Order.rewards_per_purchase` this is the Order class method which will update customer rewards in Order model
* run `Customer.customer_total_points(customer_id)` this Customer class method takes an argument which is a `customer_id` and wll output the total points for provided customer
* run `Customer.average_points(customer_id)` this Customer class method also takes a `customer_id` as an argument and will return the avg points per order for given customer.
* run `Customer.customer_report` this Customer class method will output the report of each customer with Total points and avg points per order.

* Next Steps
Next steps in this api to implement rake task/s which runs the method from models and update the database.
Once we have rake tasks completed then we want to implement controllers which will return a json or requested format
