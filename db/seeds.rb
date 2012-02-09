# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Product.delete_all
Product.create(title: 'One dozen Apples',
  description: 'A dozen of the finest apples.',
  image_url:   'apple.jpg',    
  price: 5.00)
# . . .
Product.create(title: 'Bag of Oranges',
  description:'A bag of tasty oranges.',
  image_url: 'orange.jpg',
  price: 20.00)
# . . .
Product.create(title: 'Bunch of Bananas',
  description:'<em>Far North Queensland</em> quality bananas.',
  image_url: 'banana.jpg',
  price: 15.00)
# . . .
Product.create(title: 'Lemon',
  description:'A lemon',
  image_url: 'lemon.jpg',
  price: 2.00)
