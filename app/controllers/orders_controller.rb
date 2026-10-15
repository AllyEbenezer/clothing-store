class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create]

  def new
    if @cart.line_items.empty?
      redirect_to cart_path, alert: "Your cart is empty!"
      return
    end
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = "pending"
    @order.total = @cart.total_price

    if @order.save
      # Create order items from cart
      @cart.line_items.each do |line_item|
        @order.order_items.create(
          product: line_item.product,
          quantity: line_item.quantity,
          price: line_item.product.price
        )
      end

      # Clear the cart
      @cart.line_items.destroy_all
      redirect_to orders_path(@order), notice: "Order placed successfully! 🎉"
    else
      render :new, alert: "Could not place order. Please try again."
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def order_params
    params.require(:order).permit(:shipping_address, :billing_address)
  end
end
