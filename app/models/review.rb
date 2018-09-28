class Review < ApplicationRecord
  belongs_to :restaurant

  validates :restaurant_id, presence: true
  validates :rating, presence: true, numericality: { only_integer: true,  greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :body, presence: true
end
