class FactoryQueueController < ApplicationController
  skip_before_action :verify_authenticity_token
  def process_queue
  	type = params[:queue]
  	quantity  = params[:quantity]
  	if type == 'basic'
  		items_in_queue = FactoryQueue.where(["queue_type = '#{type}' and processed = false"]).limit(quantity).order('created_at asc')
  		items_in_queue.each do |queue_item| 
  			car = Car.find(queue_item.car_id)
  			wheels = if rand(100)  < 5 then 'defective' else 'in_place' end
  			chassis = if rand(100) < 5 then 'defective' else 'in_place' end
  			engine = if rand(100)  < 5 then 'defective' else 'in_place' end
  			car.wheels = wheels
  			car.chassis = chassis
  			car.engine = engine
  			car.virtual_stock = 'electronic_queue'
  			car.save()
  			FactoryQueue.new( queue_type:'electronic' ,car_id:car.id, processed: false ).save()
  			queue_item.processed = true
  			queue_item.save()
  		end
  	end

  	if type == 'electronic'
  		items_in_queue = FactoryQueue.where(["queue_type = '#{type}' and processed = false"]).limit(quantity).order('created_at asc')
  		items_in_queue.each do |queue_item| 
  			car = Car.find(queue_item.car_id)
  			laser = if rand(100)  < 5 then 'defective' else 'in_place' end
  			computer = if rand(100) < 5 then 'defective' else 'in_place' end
 
  			car.laser = laser
  			car.computer = computer

  			car.virtual_stock = 'painting_queue'
  			car.save()
  			FactoryQueue.new( queue_type:'painting' ,car_id:car.id, processed: false ).save()
  			queue_item.processed = true
  			queue_item.save()
  		end
  	end

  	if type == 'painting'
  		items_in_queue = FactoryQueue.where(["queue_type = '#{type}' and processed = false"]).limit(quantity).order('created_at asc')
  		items_in_queue.each do |queue_item| 
  			car = Car.find(queue_item.car_id)

  			car.virtual_stock = 'factory_stock'
  			car.save()
  			
  			queue_item.processed = true
  			queue_item.save()
  		end
  	end

    render :layout => false , :json => "{queue: #{params[:queue]}, quantity: #{params[:quantity]} }"

  end
end
