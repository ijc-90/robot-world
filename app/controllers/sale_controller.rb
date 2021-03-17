class SaleController < ApplicationController
  skip_before_action :verify_authenticity_token

  def change_model_or_refund
    sale_id = params[:sale_id]
    new_model_id = params[:new_model_id]
    new_model = Model.find(new_model_id.to_i)
    sale = Sale.find(sale_id.to_i)
    car_refunded = Car.find(sale.car_id)
    car_for_sale = Car.where("virtual_stock = 'store_stock' and model_id = #{new_model_id}").limit(1)
    if car_for_sale.length() == 0
        sale.status = 'refunded'
        car_refunded.virtual_stock = 'store_stock'
        car_refunded.save()
        sale.save()
        render :layout => false , :json => {action:"refund", amount:sale.price}
    else
        car = car_for_sale[0]
        car.virtual_stock = 'sold'
        car_refunded.virtual_stock = 'store_stock'
        old_price = sale.price
        new_price = new_model.price
        sale.price = new_price
        sale.car_id = car.id
        sale.save()
        car.save()
        car_refunded.save()

        render :layout => false , :json => {action:"change_model", new_car_id: car.id, aditional_pay: new_price - old_price}
    end


  end
  
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
        complain = CustomerComplain.new(complain_type: 'no_stock_for_purchase', description: "trying to buy #{model.name} but no stock found. Stock in factory: #{factory_stock_available}")
        complain.save()

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

