Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Adds a new child to a given parent
  post "insert_child", to: "areas#insert_child"

  # Updates a given area
  put "update_area/:id", to: "areas#update_area"

  # Get areas
  get "get_areas", to: "areas#get_areas"
end
