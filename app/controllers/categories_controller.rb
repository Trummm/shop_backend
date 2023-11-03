class CategoriesController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index products_of_category]

  def index
    @categories = Category.all 

    render json: @categories
  end 

  def products_of_category 
    @category = Category.find_by(params[:id])

    @products_of_category = @category.products

    render json: @products_of_category
  end 
end
