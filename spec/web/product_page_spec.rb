require 'spec_helper'
require 'nokogiri'

describe 'The product page' do
  include Rack::Test::Methods

  def app
    Springtee::Web
  end

  let(:product) { Springtee::Product.find(1) }

  before do
    get "/products/1"
    expect(last_response.status).to eq 200
    @page = Nokogiri::HTML(last_response.body)
  end

  it 'shows the title of the product' do
    expect( @page.css('h1').text ).to eq(product.name)
  end

  it 'shows the image of the product' do
    expect( @page.css('img')[0]['src'] ).to eq(product.image_url)
  end

end

