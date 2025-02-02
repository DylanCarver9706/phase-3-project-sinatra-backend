class CustomersController < ApplicationController

   get "/customers" do
      customers = Customer.all
      # iterate thru optional query parameters
      if params.length > 0
         params.each do |var, val|
            customers = customers.search(var, val)
         end
      end
      # return
      { data: customers, status: 200 }.to_json
   end

   get "/customers/new" do
      customer = Customer.create()
      { data: customer, status: 201 }.to_json
   end

   get "/customers/:id" do
      id = params[:id]
      customer = Customer.find(id)
      { data: customer, status: 200 }.to_json
   end

   patch "/customers/:id/edit" do
      id = params[:id]
      customer = Customer.find(id)
      edits = JSON.parse(request.body.read)
      customer.update(edits)
      { data: customer, status: 200 }.to_json
   end

   post "/customers" do
      info = JSON.parse(request.body.read)
      customer = Customer.create_or_find_by(info) do |customer|
         customer.join_date = Date.today
      end
      { data: customer, status: 201 }.to_json
   end

   delete "/customers/:id/delete" do
      id = params[:id]
      Customer.find(id).destroy
      { data: nil, status: 204 }.to_json
   end
   
end