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

product = Product.find_or_create_by!(name: 'Men\'s Classy shirt') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 10
  p.price = 64.99
  p.category = cat1
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('apparel1.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'Women\'s Zebra pants') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 18
  p.price = 124.99
  p.category = cat1
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('apparel2.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'Hipster Hat') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 4
  p.price = 34.49
  p.category = cat1
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('apparel3.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'Hipster Socks') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 8
  p.price = 25.00
  p.category = cat1
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('apparel4.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'Russian Spy Shoes') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 8
  p.price = 1_225.00
  p.category = cat1
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('apparel5.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'Human Feet Shoes') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 82
  p.price = 224.50
  p.category = cat1
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('apparel6.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'Modern Skateboards') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 40
  p.price = 164.49
  p.category = cat2
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('electronics1.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'Hotdog Slicer') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 3
  p.price = 26.00
  p.category = cat2
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('electronics2.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'World\'s Largest Smartwatch') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 32
  p.price = 2_026.29
  p.category = cat2
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('electronics3.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'Optimal Sleeping Bed') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 320
  p.price = 3_052.00
  p.category = cat3
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('furniture1.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'Electric Chair') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 2
  p.price = 987.65
  p.category = cat3
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('furniture2.jpg')
  product.save!
end

product = Product.find_or_create_by!(name: 'Red Bookshelf') do |p|
  p.description = Faker::Hipster.paragraph(sentence_count: 4)
  p.quantity = 0
  p.price = 2_483.75
  p.category = cat3
end
if product.image.file.nil? || !File.exist?(product.image.path)
  product.image = open_asset('furniture3.jpg')
  product.save!
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
