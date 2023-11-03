class ProductsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index search]
  before_action :find_product
  
  def index 
    @products = Product.all

    render json: @products
  end

  def create 
    @product = current_user.products.new(product_params)

    if @product.save
      render json: { status: 'Success', product: @product }
    else
      render json: { status: 'error', errors: @product.errors.full_messages }
    end 
  end 

  def show 
    render json: @product
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

  private 

  def product_params
    params.require(:product).permit(:name, :description, :price, :user_id, :category_id)
  end 

  def find_product 
    @product = Product.find_by(id: params[:id)])

    return render json: {errors: ["Product not found!"]}, status: 404 if @product.blank?
  end 

end
