class Product < ActiveRecord::Base
  
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
  
  
end
