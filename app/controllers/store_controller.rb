class StoreController < ApplicationController
  
  def index
    @products = Product.order(:title)
    
    @count = increment_count
    
    session[:name] = "David"
    session[:day] = Date.today
    session[:time] = Time.now
    
    
  end
  
  private
  
    def increment_count
      session[:counter] ||= 0
      session[:counter] += 1
    end
    
end
