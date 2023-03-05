class ItemsController < ApplicationController
  def new
    return if params[:search].blank?
    raw_response = Faraday.get "https://pokeapi.co/api/v2/item/#{params[:search]}"
    if raw_response.status == 200
      response = JSON.parse(raw_response.body)
      @item = Item.new(item_id: response["id"], name: response["name"], image_url: response["sprites"]["default"])
    else
      redirect_to root_path
    end
  end
end
