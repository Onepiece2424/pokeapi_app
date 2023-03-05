class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end

  def new
    return if params[:search].blank?

    raw_response = Faraday.get "https://pokeapi.co/api/v2/pokemon/#{params[:search]}"
    if raw_response.status == 200
      response = JSON.parse(raw_response.body)

      File.open("pokemon.json") do |file|

        # JSONファイルを読み込む
        json = JSON.load(file)

        # ポケモン名の先頭を大文字にする
        keyword = response["name"].capitalize

        # JSONファイルの中から検索
        result = json.select { |x| x["en"].include?(keyword) }

        # 変数に代入
        val = result[0]["ja"]

        # Pokemonインスタンスを生成
        @pokemon = Pokemon.new(order: response["id"], name: val, image_url: response["sprites"]["front_default"])
      end
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
