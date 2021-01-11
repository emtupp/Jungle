class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]

  def total_products
    @products = Product.count
  end
  helper_method :total_products

  def total_categories
    @category = Category.count
  end
  helper_method :total_categories

  def show
  end
end