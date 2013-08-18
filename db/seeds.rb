# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |i|
  u = User.new(
      :email => "email#{Time.new.usec}@domain.com",
      :password => '12341234',
      :name => "Robot R2D#{i}"
  )
  u.save!
  FactoryGirl.create(:solution)
end

User.create!(name: "Michael G", email: "mpgarate@gmail.com", password: "banana123")
User.create!(name: "Annika M", email: "annikamonari@gmail.com", password: "banana123")
Admin.create!(email: "mpgarate@gmail.com", password: "banana123")
Admin.create!(email: "annikamonari@gmail.com", password: "banana123")
