class CartController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || current_user.create_cart
  end

  def add
    product = Product.find(params[:product_id])
    cart = current_user.cart || current_user.create_cart

    line_item = cart.line_items.find_or_initialize_by(product: product)
    line_item.quantity += 1
    line_item.save

    redirect_to cart_path, notice: "#{product.name} added to cart!"
  end

  def update
    line_item = LineItem.find(params[:id])
    line_item.update(quantity: params[:quantity])
    redirect_to cart_path, notice: "Cart updated!"
  end

  def remove
    line_item = LineItem.find(params[:id])
    line_item.destroy
    redirect_to cart_path, notice: "Item removed from cart."
  end
end
