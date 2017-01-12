class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :endorsements
  validates :rating, inclusion: (1..5)
  validates :user_id, length: { minimum: 1 }, allow_nil: true
  validates :restaurant_id, length: { minimum: 1 }, allow_nil: true
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
end
