require 'rails_helper'

describe Restaurant, type: :model do

  let( :user ){ double :user }

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    pending("we have to stub User model here")
    Restaurant.new(name: "Moe's Tavern", user_id: 1)
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end

end
