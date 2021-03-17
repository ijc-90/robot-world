require 'net/http'

class QualityControlAndTransportationController < ApplicationController
  skip_before_action :verify_authenticity_token
  def move_to_destination
    cars = Car.where("virtual_stock = 'factory_stock'")
    cars.each do |car| 
        if car.wheels == 'defective' or car.chassis == 'defective' or car.laser == 'defective' or car.computer == 'defective' or car.engine == 'defective'
            destination = 'discard'


            args = {"text":"Detected defects on #{car.id}"}
            url =  URI("https://hooks.slack.com/services/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")
            response = Net::HTTP.post_form(url, args)

        else
            destination = 'store_stock'
        end
        car.virtual_stock = destination
        car.save()

    end

  end
end

