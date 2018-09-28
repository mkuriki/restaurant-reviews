class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
    @category_collection = Category.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.categories = Category.where(id: params[:restaurant][:category_ids])

    if Restaurant.find_by(name: @restaurant.name, city: @restaurant.city, state:  @restaurant.state)
      flash.now[:alert] = "Restaurant not added - DUPLICATE"
      render :new
    else
      if @restaurant.save
        flash[:notice] = "Restaurant added successfully"
        redirect_to @restaurant
      else
        flash.now[:alert] = "Restaurant not added - ERROR"
        @category_collection = Category.all
        render :new
      end
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(
      :name,
      :address,
      :city,
      :state,
      :zip,
      :description
    )
  end
end
