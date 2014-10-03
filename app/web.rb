require 'sinatra/base'
require 'springtee/product'

module Springtee
  class Web < Sinatra::Base

    get '/' do
      redirect to('/products/1')
    end

    get '/products/:id' do
      product = Product.find(params[:id].to_i)

      etag product.etag
      erb :product, :locals => {:product => product, :title => "#{product.name} | Springtee"}
    end

    get '/login' do
      erb :login, :locals => {:title => "Login | Springtee"}
    end

    post '/login' do
      response.set_cookie 'user_email', params['email']

      redirect to('/products/1')
    end

  end
end
