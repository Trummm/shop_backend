class CartItemsController < ApplicationController
  def add 
    @product = Product.find_by(id: params[:product_id])

    @cart = current_user.cart 
  end 
end
