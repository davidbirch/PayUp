class Product < ActiveRecord::Base
  
  # a product can be part of many line items
  has_many :line_items
  has_many :orders, through: :line_items
  
  # cannot destroy a product if line items exist
  before_destroy :ensure_not_referenced_by_any_line_item
  
  # validate these mandatory fields
  validates :title, :description, :image_url, presence: true
  
  # validate the price is a positive value
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  
  # validate a unique title
  validates :title, uniqueness: true
  
  # validate the image refers to a url
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)$}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
    }
  
  private
    
    # ensure that there are no line items referencing this product

    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
  
  
end
