class Item < ApplicationRecord
  validates :item_id, presence: true
  validates :name, presence: true
  validates :image_url, presence: true
end
