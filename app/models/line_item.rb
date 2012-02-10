class LineItem < ActiveRecord::Base
  
  # many line items belong in a cart and cannot exist without a cart
  belongs_to :cart
  
  # a line item has one product
  belongs_to :product
  
  def total_price
    product.price * quantity
  end
  
end
