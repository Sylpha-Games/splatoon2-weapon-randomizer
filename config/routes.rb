Rails.application.routes.draw do

  root to: 'toppages#index'
  get 'achievement', to: 'toppages#achievement'
  get 'main_weapon_total_ranking', to: 'toppages#main_weapon_total_ranking'
  get 'main_weapon_max_ranking', to: 'toppages#main_weapon_max_ranking'
  get 'main_weapon_average_ranking', to:'toppages#main_weapon_average_ranking'
  get 'stage_total_ranking', to: 'toppages#stage_total_ranking'
  get 'stage_max_ranking', to: 'toppages#stage_max_ranking'
  get 'stage_average_ranking', to:'toppages#stage_average_ranking'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:create, :show, :edit, :update, :destroy]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  post 'main_weapons/random', to: 'main_weapons#random'
  post 'main_weapons/random_destroy', to: 'main_weapons#random_destroy'
  resources :main_weapons, only: [:index, :show]

  resources :stages, only: [:index, :show]

  resources :gears, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :gear_sets, only: [:index, :edit, :update, :destroy]
  
  get 'battle_records/new/:main_weapon_id', to: 'battle_records#new'
  post 'battle_records/:main_weapon_id', to: 'battle_records#create'
  resources :battle_records, only: [:index, :edit, :update, :destroy]

end
