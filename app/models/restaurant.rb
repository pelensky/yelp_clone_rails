class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :reviews, -> { extending WithUserAssociationExtension } , dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true
  validates :user_id, length: { minimum: 1 }, allow_nil: true

  def average_rating
  return 'N/A' if reviews.none?
  reviews.average(:rating)
end

end
