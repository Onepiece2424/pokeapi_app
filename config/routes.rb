Rails.application.routes.draw do
  root 'pokemons#index'
  resources :pokemons, :items
end
