# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding Data ..."

# Helper functions
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

# Let's do this ...

## CATEGORIES

puts "Finding or Creating Categories ..."

cat1 = Category.find_or_create_by! name: 'Apparel'
cat2 = Category.find_or_create_by! name: 'Electronics'
cat3 = Category.find_or_create_by! name: 'Furniture'

## PRODUCTS

puts "Finding or Creating Products ..."

Product.find_or_create_by!(name: 'Men\'s Classy shirt') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('apparel1.jpg')
  product.quantity = 10
  product.price = 64.99
  product.category = cat1
end

Product.find_or_create_by!(name: 'Women\'s Zebra pants') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('apparel2.jpg')
  product.quantity = 18
  product.price = 124.99
  product.category = cat1
end

Product.find_or_create_by!(name: 'Hipster Hat') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('apparel3.jpg')
  product.quantity = 4
  product.price = 34.49
  product.category = cat1
end

Product.find_or_create_by!(name: 'Hipster Socks') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('apparel4.jpg')
  product.quantity = 8
  product.price = 25.00
  product.category = cat1
end

Product.find_or_create_by!(name: 'Russian Spy Shoes') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('apparel5.jpg')
  product.quantity = 8
  product.price = 1_225.00
  product.category = cat1
end

Product.find_or_create_by!(name: 'Human Feet Shoes') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('apparel6.jpg')
  product.quantity = 82
  product.price = 224.50
  product.category = cat1
end

Product.find_or_create_by!(name: 'Modern Skateboards') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('electronics1.jpg')
  product.quantity = 40
  product.price = 164.49
  product.category = cat2
end

Product.find_or_create_by!(name: 'Hotdog Slicer') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('electronics2.jpg')
  product.quantity = 3
  product.price = 26.00
  product.category = cat2
end

Product.find_or_create_by!(name: 'World\'s Largest Smartwatch') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('electronics3.jpg')
  product.quantity = 32
  product.price = 2_026.29
  product.category = cat2
end

Product.find_or_create_by!(name: 'Optimal Sleeping Bed') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('furniture1.jpg')
  product.quantity = 320
  product.price = 3_052.00
  product.category = cat3
end

Product.find_or_create_by!(name: 'Electric Chair') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('furniture2.jpg')
  product.quantity = 2
  product.price = 987.65
  product.category = cat3
end

Product.find_or_create_by!(name: 'Red Bookshelf') do |product|
  product.description = Faker::Hipster.paragraph(4)
  product.image = open_asset('furniture3.jpg')
  product.quantity = 0
  product.price = 2_483.75
  product.category = cat3
end


puts "Finding or Creating Admin ..."

admin = User.find_or_initialize_by(email: "admin@jungle.test")
if admin.new_record?
  admin.name = "Admin"
  admin.password = "password"
  admin.password_confirmation = "password"
  admin.admin = true
  admin.save!
else
  admin.update_column(:admin, true)
end

puts "DONE!"
