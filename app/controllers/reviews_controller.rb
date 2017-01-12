class ReviewsController < ApplicationController

  def new
    @user = current_user
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating, :restaurant_id, :user_id)
  end
end
