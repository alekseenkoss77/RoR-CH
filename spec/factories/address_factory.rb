FactoryBot.define do
  factory :address do
    address1 { Faker::Address.street_address }
    city { Faker::Address.city }
    zipcode { 58517 }
    state { Faker::Address.state_abbr }
    user
  end
end
