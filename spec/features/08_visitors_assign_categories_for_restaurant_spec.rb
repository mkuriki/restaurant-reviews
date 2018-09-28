require 'rails_helper'

# [ ] On the create a new restaurant page, I should see checkboxes for all the categories.
# [ ] Upon successful form submission, I should see the names of the categories which were selected on the form to be present on the restaurant's details page.

feature "visitor assigns categories to a restaurant on creation" do
  let!(:breakfast) do
    Category.create(name: "Breakfast")
  end

  let!(:brunch) do
    Category.create(name: "Brunch")
  end

  let!(:cafe) do
    Category.create(name: "Cafe")
  end

  let!(:french) do
    Category.create(name: "French")
  end

  let!(:american) do
    Category.create(name: "American")
  end

  scenario "sees all available restaurant categories checkbox on the new restaurant creation page " do
    visit new_restaurant_path

    expect(page).to have_selector("#restaurant_category_ids_#{breakfast.id}")
    expect(page).to have_selector("#restaurant_category_ids_#{brunch.id}")
    expect(page).to have_selector("#restaurant_category_ids_#{cafe.id}")
    expect(page).to have_selector("#restaurant_category_ids_#{french.id}")
    expect(page).to have_selector("#restaurant_category_ids_#{american.id}")

    expect(page).to have_content(breakfast.name)
    expect(page).to have_content(brunch.name)
    expect(page).to have_content(cafe.name)
    expect(page).to have_content(french.name)
    expect(page).to have_content(american.name)
  end

  scenario "sees all selected categories assigned to a restaurant on the details page" do
    visit new_restaurant_path

    fill_in 'Name', with: "The Green Bean"
    fill_in 'Address', with: "241 Main St."
    fill_in 'City', with: "Northampton"
    fill_in 'State', with: "MA"
    fill_in 'Zip', with: "01060"
    fill_in 'Description', with: "Breakfast All Day Every Day. Complete Lunch menu. Premium Coffee and Baked Goods."

    page.check("Breakfast")
    page.check("Brunch")
    page.check("Cafe")

    click_button "Add Restaurant"

    expect(page).to have_content("Restaurant added successfully")
    expect(page).to have_content("The Green Bean")
    expect(page).to have_link(breakfast.name, href: category_path(breakfast.id))
    expect(page).to have_link(brunch.name, href: category_path(brunch.id))
    expect(page).to have_link(cafe.name, href: category_path(cafe.id))
  end
end
