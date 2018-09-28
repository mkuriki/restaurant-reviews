class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :restaurant, index: true
      t.integer :rating, null: false
      t.text :body, null: false
      t.timestamps null: false
    end

    add_foreign_key :reviews, :restaurants
  end
end
