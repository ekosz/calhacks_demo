module Springtee
  Product = Struct.new(:id, :name, :image_url) do
    def self.find(id)
      sleep(rand)
      Springtee::Product::PRODUCTS.fetch(id)
    end
  end

  Product::PRODUCTS = {
    1 => Product.new(1, "Mac's Brown Bottle Ale", 'http://images.teespring.com/shirt_pic/1320515/765931/2/566/front.jpg?v=2014-09-14-13-49'),
    2 => Product.new(2, 'Tees for the Tesla Museum!', 'http://images.teespring.com/shirt_pic/1177616/550027/6/647/front.jpg?v=2014-08-07-21-11')
  }
end


