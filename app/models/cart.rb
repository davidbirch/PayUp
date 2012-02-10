class Cart < ActiveRecord::Base
  
  # a cart has many line items and line items cannot exist without a cart
  has_many :line_items, dependent: :destroy
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  
end
