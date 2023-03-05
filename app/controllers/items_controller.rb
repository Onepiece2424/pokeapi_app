class ItemsController < ApplicationController
  def new
    raw_response = Faraday.get "https://pokeapi.co/api/v2/item/#{params[:search]}"

    if raw_response.status == 200
      @item = JSON.parse(raw_response.body)
    else
      redirect_to new_pokemon_path
    end
  end
end
