class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      
      t.string :address1
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      
      t.string :description
      
      t.date :card_expires_on
      
      t.timestamps
    end
  end
end
