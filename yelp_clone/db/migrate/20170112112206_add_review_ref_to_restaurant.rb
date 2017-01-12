class AddReviewRefToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_reference :restaurants, :review, foreign_key: true
  end
end
