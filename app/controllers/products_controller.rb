class ProductsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index search]
  
  def index 
    @products = Product.all

    render json: @products
  end

  def search 
    @products = Product.all

    #filter with name
    @products = @products.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?

    #filter with price
    @products = @products.where("CONVERT(price, DECIMAL(10,2)) >= ?", params[:price_min].to_d) if params[:min_price].present?
    @products = @products.where("CONVERT(price, DECIMAL(10,2)) <= ?", params[:price_max].to_d) if params[:max_price].present?

    #filter with description 
    @products = @products.where("description LIKE ?", "%#{params[:description]}%") if params[:description].present?

    render json: @products
  end 
end
