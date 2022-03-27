FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    cost { Faker::Commerce.price }
    msrp { Faker::Commerce.price }
    sku { SecureRandom.hex(6) }
  end
end
