class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  def total_price
    line_items.sum { |item| item.product.price * item.quantity }
  end
end
