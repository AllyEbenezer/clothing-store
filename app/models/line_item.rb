class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def subtotal
    product.price * quantity
  end
end
