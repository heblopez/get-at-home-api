require "faker"

puts "Start DB seed"

user_test = User.create(name: "testino", email: "testino@mail.com", password: "123456")

(1..20).each do |i|
  operation = Faker::Boolean.boolean ? 'rent' : 'sale'
  property = Faker::Boolean.boolean ? 'apartment' : 'house'
  numberRandom = Faker::Number.between(from: 1, to: 5)
  
  property = Property.create(address: Faker::Address.full_address, type_operation: operation, type_property: property, bedrooms: numberRandom, bathrooms: numberRandom, area: Faker::Number.between(from: 1, to: 200))
end

properties = Property.all

properties.map{|property| user_test.users_props.create(property_id: property.id)}
puts "End DB seed"