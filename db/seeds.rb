1.upto(5) do |i|
  Patient.create!(email: Faker::Internet.unique.email, password: "111111", name: Faker::Name.unique.name, age: Faker::Number.number(digits: 2), gender: Faker::Gender.binary_type)
end

1.upto(3) do |i|
  Doctor.create!(email: Faker::Internet.unique.email, password: "111111", name: Faker::Name.unique.name)
end