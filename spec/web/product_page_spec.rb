require 'spec_helper'
require 'nokogiri'

describe 'The product page' do
  include Rack::Test::Methods

  def app
    Springtee::Web
  end

  let(:product) { Springtee::Product.find(1) }

  context 'getting the product from scratch' do

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

    it 'sets an etag for the product' do
      expect( last_response.headers['Etag'] ).to_not be_nil
    end

  end

  context 'using an etag' do
    it 'gives us a 304 Not Modified' do
      cold_resonse = get('/products/1')
      etag = cold_resonse.headers['Etag']

      hot_response = get('/products/1', {}, { 'HTTP_IF_NONE_MATCH' => etag })

      expect( hot_response.status ).to eq(304)
    end
  end

end

