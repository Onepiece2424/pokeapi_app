class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.integer :order, null: false
      t.string :name, null: false
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
