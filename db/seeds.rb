require 'faker'

 admin = User.new(
   # name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
 )
 admin.skip_confirmation!
 admin.save!

#  #Create test user
# test = User.new(
#   email: 'test@example.com',
#   password: 'helloworld'
#   )

# test.skip_confirmation!
# test.save
 
 5.times do
  registered_portfolios = Portfolio.create!(
    # user: test,
    name: Faker::Commerce.color
    )
end

registered_portfolios = Portfolio.all

#Create events
10.times do
  stocks = Stock.create!(
    portfolio: registered_portfolios.sample,
    # event_name: Faker::Hacker.say_something_smart
    stock_symbol: Faker::Lorem.characters(4) 
    )
end


puts "Seeds finished"
puts "#{Portfolio.count} applications created"
puts "#{Stock.count} events created"
