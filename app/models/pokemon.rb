class Pokemon < ApplicationRecord
  validates :order, presence: true
  validates :name, presence: true
  validates :image_url, presence: true
end
