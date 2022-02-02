Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/customer/customers_report', to: 'customer#customers_report'
end
