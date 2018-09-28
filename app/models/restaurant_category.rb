class RestaurantCategory < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category

  validates :restaurant, presence: true
  validates :category, presence: true
end
