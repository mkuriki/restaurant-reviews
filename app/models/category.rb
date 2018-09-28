class Category < ApplicationRecord
  has_many :restaurant_categories
  has_many :restaurants, through: :restaurant_categories

  validates :name, presence: true
end
