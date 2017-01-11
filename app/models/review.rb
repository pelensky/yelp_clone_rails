class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  validates :rating, inclusion: (1..5)
  validates :user_id, length: { minimum: 1 }, allow_nil: true
  validates :restaurant_id, length: { minimum: 1 }, allow_nil: true
end
