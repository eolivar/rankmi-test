# README

Ruby version: 2.4.2
Rails version: 5.1.4
PostgreSql version: 9.5

After cloning the project you should execute:
- bundle install
- bundle exec rake db:create db:migrate db:seed

Endpoints:
- POST /insert_child -> Inserts a child on a given parent
- PUT /update_area/:id -> Updates a given area
- GET /get_areas -> Get all the areas
