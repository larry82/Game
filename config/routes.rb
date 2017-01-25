Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  

  root 'playground#index'
  get :search_for_monsters,:engage,controller: :playground




end
