require 'spec_helper'
require 'nokogiri'

describe 'The login page' do
  include Rack::Test::Methods

  def app
    Springtee::Web
  end

  context 'GET /login' do
    before do
      get "/login"
      expect(last_response.status).to eq 200
      @page = Nokogiri::HTML(last_response.body)
    end

    it 'shows the login form' do
      form = @page.css('form')[0]
      email_field = @page.css('input[name="email"]')[0]
      password_field = @page.css('input[name="password"]')[0]

      expect( form ).to_not be_nil
      expect( email_field ).to_not be_nil
      expect( password_field ).to_not be_nil
    end
  end

  context 'POST /login' do
    before do
      post '/login', :email => 'foo@bar.com', :password => 'xxx'
      expect(last_response.status).to eq 302
    end

    it 'logs the user in' do
      expect( rack_mock_session.cookie_jar["user_email"] ).to eq('foo@bar.com')
    end
  end
end
