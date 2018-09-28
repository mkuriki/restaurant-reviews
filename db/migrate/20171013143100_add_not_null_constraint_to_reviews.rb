class AddNotNullConstraintToReviews < ActiveRecord::Migration[5.0]
  def up
    change_column :reviews, :restaurant_id, :integer, null: false
  end

  def down
    change_column :reviews, :restaurant_id, :integer
  end
end
