class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @user = current_user
    @restaurant = Restaurant.find(params[:restaurant_id])
    review = @restaurant.reviews.create(review_params)
    @user.reviews << review
    @user.save
    redirect_to '/restaurants'
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
