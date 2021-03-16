#!/usr/bin/env ruby
require 'net/http'
require 'json'


args = {}
url =  URI("http://localhost:3000/purchase")
response = Net::HTTP.post_form(url,  args)

#puts "start"
if response.code.to_i == 200
	r_body = JSON.parse(response.body)
#	puts r_body
	if r_body['success']
		puts "purchase car of model #{r_body['model_name']}"
	else
		if r_body['available_in_factory']
			puts "request stock from factory"
			stock_from_factory_response = Net::HTTP.post_form(URI("http://localhost:3000/quality_control_and_transportation"),  {})
			puts "retry purchase after stock transportation"
			retry_purchase_response = Net::HTTP.post_form(URI("http://localhost:3000/purchase"),  {}) 
			retry_purchase_body = JSON.parse(retry_purchase_response.body)
			puts retry_purchase_body
			if retry_purchase_response.code.to_i == 200 
				if retry_purchase_body["success"]
					puts "purchase car of model #{retry_purchase_body['model_name']}"
				else
					puts "unable to purchase after retry. response status: #{retry_purchase_response.code}"
				end


			else
				puts "unable to purchase after retry. response status: #{retry_purchase_response.code}"
			end

		else
			puts "unable to purchase. No stock in factory also"
		end

	end
else
	puts "response_code #{response.code}"
end
