class Restaurant < ApplicationRecord
  has_many :reviews, -> { extending WithUserAssociationExtension }, dependent: :destroy

  belongs_to :user
  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    return 'N/A' if reviews.none?
    array = []
    reviews.each do |review|
      array << review.rating
    end
    array.inject(:+) / array.length
  end
  # def average_rating
  #   return 'N/A' if reviews.none?
  #   reviews.average(:rating)
  # end

end
