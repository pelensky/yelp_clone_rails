require 'rails_helper'

describe ReviewsHelper, :type => :helper do
  context 'star rating' do
    it 'shows N/A if now reviews' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end
  end

  it 'returns five full stars for 5' do
    expect(helper.star_rating(5)).to eq '★★★★★'
  end

  it 'returns three full two empty stars for 3' do
    expect(helper.star_rating(3)).to eq '★★★☆☆'
  end

  it 'returns four black stars and one white star for 3.5' do
    expect(helper.star_rating(3.5)).to eq '★★★★☆'
  end
end
