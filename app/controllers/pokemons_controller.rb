class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end

  def new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      redirect_to pokemons_path, notice: "「#{@pokemon.name}」をゲットしました。"
    else
      render :new
    end
  end

  # ポケモン名で検索
  def search
    @search = params[:search]
    File.open("pokemon.json") do |file|
      json = JSON.load(file)
      result = json.select { |x| x["ja"].include?(@search) }
      if result.present?
        val = result[0]["en"].downcase
        raw_response = Faraday.get "https://pokeapi.co/api/v2/pokemon/#{val}"
        raw_response.status == 200
        response = JSON.parse(raw_response.body)

        @pokemon = Pokemon.new(order: response["id"], name: @search, image_url: response["sprites"]["front_default"])
      else
        redirect_to root_path
      end
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:order, :name, :image_url)
  end
end
