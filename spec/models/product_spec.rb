require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new(name: 'test')
    end
    it 'should save successfully when all fields are set' do
      @product = Product.new(name: 'test', price: 100, quantity: 1, category: @category)
      expect(@product).to be_valid
    end

    it 'should validate name' do
      @product = Product.new(name: nil, price: 100, quantity: 1, category: @category)
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should validate price' do
      @product = Product.new(name: 'test', price: nil, quantity: 1, category: @category)

      epect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should validate quantity' do
      @product = Product.new(name: 'test', price: 100, quantity: nil, category: @category)
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should validate category' do
      @product = Product.new(name: 'test', price: 100, quantity: 1, category: nil)
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
