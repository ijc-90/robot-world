class RobotBuilderController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create_cars
    created_cars = []
    models = Model.all
    l = models.length()
    
    for i in 1..params[:quantity].to_i
    	model_for_this_car = models[rand(l)]
    	puts "this model  #{model_for_this_car.id} "
    	car = Car.new(model_id: model_for_this_car.id, virtual_stock:'basic_queue',wheels: 'pending' ,chassis: 'pending' ,laser: 'pending' ,computer: 'pending' ,engine: 'pending' ,year: 2021 ,cost: 1 )
    	created_cars.push(car)
    end
    created_cars.each(&:save)
    created_cars.each do |car| 
    	enqueue = FactoryQueue.new( queue_type:'basic' ,car_id:car.id, processed: false ) 
    	enqueue.save()
    end
    @created_cars = created_cars
    
  end
end

