class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params.require(:restaurant_id))
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params.require(:restaurant_id))
    @review = @restaurant.reviews.build(review_params)

    if @review.save
      flash[:notice] = "Review added successfully"
      redirect_to restaurant_path(params[:restaurant_id])
    else
      flash[:alert] = "Review not added - ERROR"
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :body
    )
  end
end
