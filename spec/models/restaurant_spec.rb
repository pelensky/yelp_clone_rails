require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
end

describe 'reviews' do
  describe 'build_with_user' do
    let(:user) { User.create email: 'test@test.com' }
    let(:restaurant) { Restaurant.create name: 'Test' }
    let(:review_params) { {rating: 5, thoughts: 'yum'} }
    subject(:review) { restaurant.reviews.build_with_user(review_params, user) }
    it 'builds review' do
      expect(review).to be_a Review
    end
    it 'builds a review associated with the specified user' do
      expect(review.user).to eq user
    end
  end
end

describe 'average rating' do
  context 'no reviews' do
    it 'returns N/A' do
      user = User.create(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
      restaurant = Restaurant.create(name: 'The Ivy', user_id: user.id)
      expect(restaurant.average_rating).to eq 'N/A'
    end
  end

  context 'one review' do
    it 'shows rating' do
      user = User.create(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
      restaurant = Restaurant.create(name: 'The Ivy', user_id: user.id)
      restaurant.reviews.create_with_user({rating: 4}, user)
      expect(restaurant.average_rating).to eq 4
    end
  end

  context 'multiple reviews' do
    it 'shows average' do
      user = User.create(email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
      user2 = User.create(email: 'user2@test.com', password: 'testtest', password_confirmation: 'testtest')
      restaurant = Restaurant.create(name: 'The Ivy', user_id: user.id)
      restaurant.reviews.create_with_user({rating: 1}, user)
      restaurant.reviews.create_with_user({rating: 5}, user2)
      expect(restaurant.average_rating).to eq 3
    end
  end
end
