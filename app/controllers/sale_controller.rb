class SaleController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def purchase
    created_cars = []
    models = Model.where("id = #{params[:model_id]}")
    model = models[0]
    @model = model
    
    car_for_sale = Car.where("virtual_stock = 'store_stock' and model_id = #{model.id}").limit(1)
    if car_for_sale.length() == 1
        car = car_for_sale[0]
        car.virtual_stock = 'sold'
        sale = Sale.new(car_id: car.id, price: model.price, status:"sold" )
        sale.save()
        car.save()
        response = {
            success: true,
            sale_id: sale.id,
            car_id: car.id,
            model_id: model.id,
            model_name: model.name
        }.to_json
        render :layout => false , :json => response
    else
        factory_stock = Car.where("virtual_stock = 'factory_stock' and model_id = #{model.id}").limit(1)
        if factory_stock.length() > 0
            factory_stock_available = true
        else
            factory_stock_available = false
        end

        @success = false
        response = {
            success: false,
            model_id: model.id,
            model_name: model.name,
            available_in_factory: factory_stock_available
        }
        render :layout => false , :json => response
    end
  end

  def purchase_random_car
    #temp method for testing that should dissapear
    created_cars = []
    models = Model.all
    l = models.length()
    model = models[rand(l)]
    model = models[0]
    @model = model
    
    car_for_sale = Car.where("virtual_stock = 'store_stock' and model_id = #{model.id}").limit(1)
    if car_for_sale.length() == 1
        car = car_for_sale[0]
        car.virtual_stock = 'sold'
        sale = Sale.new(car_id: car.id, price: model.price, status:"sold" )
        sale.save()
        car.save()
        response = {
            success: true,
            sale_id: sale.id,
            car_id: car.id,
            model_id: model.id,
            model_name: model.name
        }.to_json
        render :layout => false , :json => response
    else
        factory_stock = Car.where("virtual_stock = 'factory_stock' and model_id = #{model.id}").limit(1)
        if factory_stock.length() > 0
            factory_stock_available = true
        else
            factory_stock_available = false
        end

        @success = false
        response = {
            success: false,
            model_id: model.id,
            model_name: model.name,
            available_in_factory: factory_stock_available
        }
        render :layout => false , :json => response
    end
    
  end
end

