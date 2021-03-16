# README

## Description of the problem
https://github.com/mejuri-inc/robot-world


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
