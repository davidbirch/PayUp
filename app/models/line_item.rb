class LineItem < ActiveRecord::Base
  
  # many line items belong in a cart and cannot exist without a cart
  belongs_to :cart
  
  # many line items belong in an order
  belongs_to :order
  
  # a line item has one product
  belongs_to :product
  
  def total_price
    product.price * quantity
  end
  
end
