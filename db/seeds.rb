# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.count == 0
	5.times do |i|
	  u = User.new(
	      :email => "email#{Time.new.usec}@domain.com",
	      :password => '12341234',
	      :name => "Robot R2D#{i}"
	  )
	  u.save!
	  FactoryGirl.create(:comment)
	end
end

aspect_data = [
	{
		title: "Problem that this business would solve"
	},
	{
		title: "Unique value proposition"		
	},
	{
		title: "Key Activities"		
	},
	{
		title: "Cost structure"		
	},
	{
		title: "Unfair Advantage"		
	},
	{
		title: "Channels"		
	},
	{
		title: "Revenue Streams & Estimates"		
	},
	{
		title: "Customer Segments"		
	},
	{
		title: "Prototype Elements"		
	}
]

Aspect.all.each do |a|
	a.destroy!
end

aspect_data.each do |d|
	Aspect.find_or_create_by(d)
end



admin_user_data = [
  { 
		email: "mpgarate@gmail.com",
		password: "banana123",
		password_confirmation: "banana123"
	},
	{
		email: "annikamonari@gmail.com",
		password: "banana123",
		password_confirmation: "banana123"
	},
	{
		email: "emily.pakulski@gmail.com",
		password: "banana123",
		password_confirmation: "banana123"
	}
]

admin_user_data.each do |d|
	FactoryGirl.create(:admin_user, d) if AdminUser.count == 0
end
