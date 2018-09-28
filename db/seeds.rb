# run rake db:reset if necessary

if Rails.env.development?
  # create restaurants
  restaurants = [
    {
      name: "Superfresh! Organic Cafe",
      address: "30 Main St",
      city: "Brattleboro",
      state: "VT",
      zip: "05301",
      description: "($$) Gluten-Free, Vegetarian, Juice Bars & Smoothies"
    }, {
      name: "The Porch Too",
      address: "648 Putney Rd",
      city: "Brattleboro",
      state: "VT",
      zip: "05301",
      description: "($) Cafes, Breakfast & Brunch, Sandwiches"
    }, {
      name: "The Vermont Country Deli",
      address: "436 Western Ave",
      city: "Brattleboro",
      state: "VT",
      zip: "05301",
      description: "($$) Delis, Specialty Food, Sandwiches"
    }
  ]

  restaurants.each do |r_params|
    name = r_params[:name]
    restaurant = Restaurant.where(name: name).first_or_initialize
    restaurant.assign_attributes(r_params)
    restaurant.save!
  end

  # add reviews to restaurant(s)
  reviews = [
    {
      restaurant_id: Restaurant.find_by(name: "Superfresh! Organic Cafe").id,
      rating: 3,
      body: "Cute vegetarian and gluten-free cafe in a cool old building that is on/over the water. Cool views out the back windows!"
    },
    {
      restaurant_id: Restaurant.find_by(name: "The Porch Too").id,
      rating: 5,
      body: "Best of the best of the best.  Such an amazing menu and wonderful staff with lots of wonderful specialty baked goods and meal specials every day."
    },
    {
      restaurant_id: Restaurant.find_by(name: "The Vermont Country Deli").id,
      rating: 4,
      body: "They have a nice selection of VT beers, cheeses, wines, maple syrup, etc.I bought a small jar of Stonehill Farm raspberry jam."
    }
  ]

  Review.delete_all

  reviews.each do |r_params|
    Review.create(r_params)
  end

  # create categories
  categories = [
    { name: "Cafe" },
    { name: "Breakfast" },
    { name: "Raw Food"}
  ]

  categories.each do |c_params|
    Category.create(c_params)
  end

  # assign categories to restaurants
  restaurant_categories = [
    {
      restaurant_id: Restaurant.find_by(name: "Superfresh! Organic Cafe").id,
      category_id: Category.find_by(name: "Raw Food").id
    },
    {
      restaurant_id: Restaurant.find_by(name: "Superfresh! Organic Cafe").id,
      category_id: Category.find_by(name: "Cafe").id
    },
    {
      restaurant_id: Restaurant.find_by(name: "The Porch Too").id,
      category_id: Category.find_by(name: "Breakfast").id
    },
    {
      restaurant_id: Restaurant.find_by(name: "The Vermont Country Deli").id,
      category_id: Category.find_by(name: "Cafe").id
    }
  ]

  RestaurantCategory.delete_all

  restaurant_categories.each do |r_c_params|
    RestaurantCategory.create(r_c_params)
  end
end
