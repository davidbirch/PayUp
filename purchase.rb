
# this is an adaption of the Active Merchant library for eWay Merchant Hosted Payment solution
# http://rubydoc.info/github/Shopify/active_merchant/master/ActiveMerchant/Billing/EwayGateway
# http://www.eway.com.au/Developer/eway-api/hosted-payment-solution.aspx

require "rubygems"
require "active_merchant"

# we are using the Test environment
ActiveMerchant::Billing::Base.mode = :test

# declare a gateway
# note: use 87654321 if you don't have an eWay sandbox account, otherwise use your sandbox account id
# you can find this by logging into the partner portal -> resources -> sandbox/testing
gateway = ActiveMerchant::Billing::EwayGateway.new(
:login => '87654321'
)

# set the value of the transaction in AUD cents
# transaction amount is a mandatory field for a purchase
money = 1500

# declare a credit card
# note: the Sandbox allows you to test any valid Visa/MasterCard credit card, however feel free to use the following test cards:
# Visa        4444333322221111
# MasterCard  5105105105105100

# these are all mandatory fields.  Some additional fields you might add are
# :type => visa,
# note that eWay asks for ewayFirstName, ewayLastName and ewayCardHolderName
# eWayCardHolderName is computed from the CreditCard object as firstname + lastname
credit_card = ActiveMerchant::Billing::CreditCard.new(
  :number => "4444333322221111",
  :verification_value => "123",
  :month => 1,
  :year => 2015,
  :first_name => "John",
  :last_name => "Citizen"
)

# set up some additional options. order_id is compulsory.  Some other options:
# :email => 'john.citizen@testmail.com',
# :description => 'purchased items'
options = {
    :order_id => '123',
    :billing_address => {
      :address1 => '10 Smith Street',
      :city => 'Collingwood',
      :state => 'VIC',
      :country => 'AU',
      :zip => '3066'
      },
}

#validate the credit card and transact
if credit_card.valid?
  response = gateway.purchase(money, credit_card, options)
  if response.success?
    puts "Purchase was a success.  #{response.message}"
  else
    puts "Error: #{response.message}"
  end
else
  puts "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
end