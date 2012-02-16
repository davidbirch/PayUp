class Order < ActiveRecord::Base
  
  # an order has many line items and line items cannot exist without an order
  has_many :line_items, dependent: :destroy
  has_many :transactions, :class_name => "OrderTransaction"
  
  attr_accessor :card_number, :card_verification, :total_price
  
  validate :validate_card, :on => :create
  
  validates :card_expires_on, :email, presence: true
  validates :address1, :city, :state, :country, :zip, presence: true
  
  def purchase
    
    #calculate the remaining options
    @options = {
      :order_id => '123',
      :billing_address => {
        :address1 => address1,
        :city => city,
        :state => state,
        :country => country,
        :zip => zip
        },
    }
    
    # process the payment
    response = GATEWAY.purchase(price_in_cents, credit_card, @options)
    
    #record the transaction
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response )
        
    # return the response from the payment
    response.success?
  end
  
  def price_in_cents
    ((total_price.to_f)*100).round
  end
    
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
    item.cart_id = nil
    line_items << item
    end
  end
  
  private
  
    def validate_card
      unless credit_card.valid?
        credit_card.errors.full_messages.each do |message|
          errors[:base] << message
          #errors.add_to_base message
        end
      end
    end
  
    def credit_card
        @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
          :number => card_number,
          :verification_value => card_verification,
          :month => card_expires_on.month,
          :year => card_expires_on.year,
          :first_name => first_name,
          :last_name => last_name 
        )
    end
end
