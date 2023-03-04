class ItemsController < ApplicationController
  def new
    raw_response = Faraday.get "https://pokeapi.co/api/v2/item/100"
    @response = JSON.parse(raw_response.body)
  end
end
