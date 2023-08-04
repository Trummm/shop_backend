# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# Tạo dữ liệu cho bảng Category
9.times do 
  Category.create!(
    name: Faker::Commerce.department,
    description: Faker::Lorem.paragraph,
    slug: Faker::Internet.slug,
    thumbnail: Faker::LoremFlickr.image(size: "300x200", search_terms: ['category', 'abstract'])
  )
end 

# Tạo dữ liệu cho bảng User
10.times do 
  User.create!(
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number,
    password: '123'
  )
end 

# Tạo dữ liệu cho bảng products, mỗi user có nhiều products
User.all.each do |user|
  9.times do
    user.products.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.sentence,
      price: Faker::Commerce.price(range: 50..500),
      category_id: 1
    )
  end
end

# Tạo dữ liệu cho bảng Cart

# Tạo dữ liệu cho bảng CartItem
