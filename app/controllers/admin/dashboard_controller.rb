class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def index
    @product_count = { value: Product.count, name: 'Product count' }
    @category_count = { value: Category.count, name: 'Category count' }
    @metrics = [@product_count, @category_count]
  end
end
