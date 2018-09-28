class CreateRestaurantCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_categories do |t|
      t.references :category, index: true
      t.references :restaurant, index: true
      t.timestamps
    end

    add_foreign_key :restaurant_categories, :categories
    add_foreign_key :restaurant_categories, :restaurants
  end
end
