require 'spec_helper'
require 'springtee/product'

describe Springtee::Product do

  describe '.find' do

    subject { Springtee::Product }

    it 'finds the correct product' do
      stub_const("Springtee::Product::PRODUCTS", {
        1 => 'a',
        2 => 'b',
      })

      expect(subject.find(1)).to eq('a')
      expect(subject.find(2)).to eq('b')
    end

  end

  subject { Springtee::Product.new(1, 'Test', 'http://google.com') }

  describe '#name' do
    it 'gives its name' do
      expect(subject.name).to eq('Test')
    end
  end

  describe '#id' do
    it 'gives its id' do
      expect(subject.id).to eq(1)
    end
  end

  describe '#image_url' do
    it 'gives its image_url' do
      expect(subject.image_url).to eq('http://google.com')
    end
  end

end
