class PokemonsController < ApplicationController
  def index
    raw_response = Faraday.get "https://pokeapi.co/api/v2/pokemon/pikachu"
    @response = JSON.parse(raw_response.body)
  end

  def new
  end
end
