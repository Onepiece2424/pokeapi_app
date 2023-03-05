class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :item_id, null:false
      t.string :name, null:false
      t.string :image_url, null:false

      t.timestamps
    end
  end
end
