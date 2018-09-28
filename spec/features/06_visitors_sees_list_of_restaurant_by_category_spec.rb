require 'rails_helper'

# [ ] I should get to this page by clicking on the name of a category while on the page with the names of all the categories.
# [ ] I should see the name of the category at the top of the page.
# [ ] I should see the name of all restaurants that belong to this category.
# [ ] I should be taken to restaurant's details page if I click on the name of a restaurant while on this page.

feature "visitor sees a list of restaurant categories" do
  let!(:breakfast) do
    Category.create(name: "Breakfast")
  end

  let!(:greek) do
    Category.create(name: "Greek")
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

  let!(:filos) do
    Restaurant.create(
      name: "Filos Greek Taverna",
      address: "279 Main St",
      city: "Northampton",
      state: "MA",
      zip: "01060"
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
      restaurant_id: filos.id,
      category_id: greek.id
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

  scenario "clicks a category link and sees a category show page with the name of the category" do
    visit categories_path
    expect(page).to have_link(breakfast.name, href: category_path(breakfast.id))
    expect(page).to have_link(greek.name, href: category_path(greek.id))
    expect(page).to have_link(moroccan.name, href: category_path(moroccan.id))

    click_link breakfast.name
    expect(page).to have_content(breakfast.name)
  end

  scenario "sees the name of all restaurants that belong to this category" do
    visit categories_path
    click_link breakfast.name

    expect(page).to have_content(green.name)
    expect(page).to have_content(mosaic.name)
  end

  scenario "clicks on the name of a restaurant, sees the restaurant's details page" do
    visit category_path(breakfast.id)
    click_link green.name

    expect(page).to have_content(green.name)
    expect(page).to have_content(green.address)
    expect(page).to have_content(green.city)
    expect(page).to have_content(green.state)
    expect(page).to have_content(green.zip)
    expect(page).to have_content(green.description)
  end
end
