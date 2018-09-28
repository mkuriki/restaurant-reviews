require 'rails_helper'

# [ ] I should see the name of all categories. (e.g. *thai*, *italian*, *chinese*)
# [ ] I should get to this page by clicking on a "Categories" link which is located on the header of every page.

feature "visitor sees a list of restaurant categories" do
  let!(:breakfast) do
    Category.create(
      name: "Breakfast"
    )
  end

  let!(:greek) do
    Category.create(
      name: "Greek"
    )
  end

  let!(:moroccan) do
    Category.create(
      name: "Moroccan"
    )
  end

  scenario "sees a list of categories" do
    visit categories_path

    expect(page).to have_content breakfast.name
    expect(page).to have_content greek.name
    expect(page).to have_content moroccan.name
  end

  scenario "link to the list of categories exists in all page header" do
    visit root_path
    click_link "Categories"
    expect(page).to have_content("Breakfast")
    expect(page).to have_content("Greek")
    expect(page).to have_content("Moroccan")

    visit restaurants_path
    click_link "Categories"
    expect(page).to have_content("Breakfast")
    expect(page).to have_content("Greek")
    expect(page).to have_content("Moroccan")
  end
end
