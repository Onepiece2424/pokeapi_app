class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    return if params[:search].blank?
    raw_response = Faraday.get "https://pokeapi.co/api/v2/item/#{params[:search]}"
    if raw_response.status == 200
      response = JSON.parse(raw_response.body)
      @item = Item.new(item_id: response["id"], name: response["name"], image_url: response["sprites"]["default"])
    else
      redirect_to new_item_path, notice: "#{raw_response.status}エラー！"
    end
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to items_path, notice: "「#{@item.name}」をゲットしました。"
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_id, :name, :image_url)
  end
end
