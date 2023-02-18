class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end

  def new
    return if params[:search].blank?

    raw_response = Faraday.get "https://pokeapi.co/api/v2/pokemon/#{params[:search]}"
    if raw_response.status == 200
      response = JSON.parse(raw_response.body)
      # Pokemonインスタンスを生成するようにします。
      @pokemon = Pokemon.new(order: response["id"], name: response["name"], image_url: response["sprites"]["front_default"])
    else
      redirect_to new_pokemon_path, notice: "#{raw_response.status}エラー！"
    end
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      redirect_to pokemons_path, notice: "「#{@pokemon.name}」をゲットしました。"
    else
      render :new
    end
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:order, :name, :image_url)
  end
end
