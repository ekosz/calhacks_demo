require 'sinatra/base'
require 'springtee/product'

module Springtee
  class Web < Sinatra::Base

    get '/products/:id' do
      product = Product.find(params[:id].to_i)

      erb :product, :locals => {:product => product, :title => "#{product.name} | Springtee"}
    end

  end
end
