# README

## Description of the problem
https://github.com/mejuri-inc/robot-world

### Clarifications on the solution
 - A backend is provided that it's highly customized for the usecase of the robots (It's not a REST CRUD)
 - The guard robot discards defective cars. There is no re-processing. (It could be relatively easy to implement if desired)
 - There is tracking on an individual level on cars. We use "virtual_stock" to represent where the car is. This shouldn't be interpreted as a literal place but rather a representation of the part of the flux where the car is currently.
 - When a car is not in stock, but there is stock in the factory, the robot requests the guard robot to bring the stock to the store. This cars where not checked for quality yet, so it can happen that there was only one car available on the factory and it was defective. In this case the sale fails.
 - The triggering of change of model is manual.
 - In case of a change of model, the change will be done immediately by the backend. Car_id and aditional_pay will be provided, since the buyer need to know which car to take, and also how much more he needs to pay. In the case of a negative "aditional_pay" the buyer get's part of the money back.
 - If there is no car in stock for the change to occur, then the car goes back to stock and the sale is marked as "refunded". The refunded amount is also provided.



## how to run
### Run migrations
```
bin/rails db:migrate
```

### Run server
```
rails server
```

### Load data for car models(optional)
```
INSERT INTO public.models (id, name, created_at, updated_at, cost, price) VALUES (2, 'ferrari', '2021-03-13 16:55:52.676136', '2021-03-13 16:55:52.676136', 10, 20);
INSERT INTO public.models (id, name, created_at, updated_at, cost, price) VALUES (3, 'maserati', '2021-03-13 16:55:52.676136', '2021-03-13 16:55:52.676136', 15, 30);
INSERT INTO public.models (id, name, created_at, updated_at, cost, price) VALUES (4, 'volkswagen', '2021-03-13 16:55:52.676136', '2021-03-13 16:55:52.676136', 20, 40);
INSERT INTO public.models (id, name, created_at, updated_at, cost, price) VALUES (5, 'bmw', '2021-03-13 16:55:52.676136', '2021-03-13 16:55:52.676136', 25, 50);
INSERT INTO public.models (id, name, created_at, updated_at, cost, price) VALUES (6, 'fiat', '2021-03-13 16:55:52.676136', '2021-03-13 16:55:52.676136', 30, 60);
INSERT INTO public.models (id, name, created_at, updated_at, cost, price) VALUES (7, 'renault', '2021-03-13 16:55:52.676136', '2021-03-13 16:55:52.676136', 35, 70);
INSERT INTO public.models (id, name, created_at, updated_at, cost, price) VALUES (8, 'peugeot', '2021-03-13 16:55:52.676136', '2021-03-13 16:55:52.676136', 40, 80);
INSERT INTO public.models (id, name, created_at, updated_at, cost, price) VALUES (9, 'mercedez benz', '2021-03-13 16:55:52.676136', '2021-03-13 16:55:52.676136', 45, 90);
INSERT INTO public.models (id, name, created_at, updated_at, cost, price) VALUES (10, 'alfa romeo', '2021-03-13 16:55:52.676136', '2021-03-13 16:55:52.676136', 50, 100);
INSERT INTO public.models (id, name, created_at, updated_at, cost, price) VALUES (11, 'audi', '2021-03-13 16:55:52.676136', '2021-03-13 16:55:52.676136', 55, 110);
```

### Available endpoints 
Examples of available endpoints are on the file [postman-robot-world.json](https://github.com/ijc-90/robot-world/blob/master/postman-robot-world.json)

Import this file into postman

### Unleash the robots
Check out the file [config/schedule.rb](https://github.com/ijc-90/robot-world/blob/master/config/schedule.rb)

You may want to edit the standard output to check out the logs
To start the factory working use the following command
```
whenever --update-crontab
```
If you have the cron service running the robots should start working. 
 - Every minute cars are created
 - Every 3 minutes the lines process the cars
 - Every 30 minute stock gets transfered to the store or discarded
 - You can manually ask for a refund on an order using `POST /purchase/:sale_id/change-model-or-refund/:new_model_id`
