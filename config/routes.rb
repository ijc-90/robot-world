Rails.application.routes.draw do
	get "/cars", to: "cars#index"

	post "/builder_robot/create_cars/:quantity", to: "robot_builder#create_cars"

	post "/process_queue/:queue/:quantity", to: "factory_queue#process_queue"

	post "/quality_control_and_transportation", to: "quality_control_and_transportation#move_to_destination"
	
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
