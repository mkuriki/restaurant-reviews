class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :restaurant_categories
  has_many :categories, through: :restaurant_categories

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true, length: { is: 5 }, numericality: { only_integer: true }
end
