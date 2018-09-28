require 'rails_helper'

# [ ] On the page for a restaurant's details, I should see all the categories that a restaurant belongs to.
# [ ] Clicking on the name of a category should take me to the page with the list of all the restaurants for that particular category.

feature "visitor sees categories for a selected restaurant" do
  let!(:breakfast) do
    Category.create(name: "Breakfast")
  end

  let!(:moroccan) do
    Category.create(name: "Moroccan")
  end

  let!(:green) do
    Restaurant.create(
      name: "The Green Bean",
      address: "241 Main St",
      city: "Northampton",
      state: "MA",
      zip: "01060",
      description: "($$) Serves breakfast and brunch"
    )
  end

  let!(:mosaic) do
    Restaurant.create(
      name: "Mosaic Cafe",
      address: "78 Masonic St",
      city: "Northampton",
      state: "MA",
      zip: "01060"
    )
  end

  before :each do
    RestaurantCategory.create(
      restaurant_id: green.id,
      category_id: breakfast.id
    )
    RestaurantCategory.create(
      restaurant_id: mosaic.id,
      category_id: moroccan.id
    )
    RestaurantCategory.create(
      restaurant_id: mosaic.id,
      category_id: breakfast.id
    )
  end

  scenario "in a restaurant's details page, user sees all categories that a selected restaurant belongs to" do
    visit restaurant_path(mosaic.id)

    expect(page).to have_content(breakfast.name)
    expect(page).to have_content(moroccan.name)
  end

  scenario "sees the name of all restaurants that belong to this category" do
    visit category_path(breakfast.id)

    expect(page).to have_content(green.name)
    expect(page).to have_content(mosaic.name)
  end
end
