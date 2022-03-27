FactoryBot.define do
  factory :order do
    number { SecureRandom.hex(5) }
    total { Faker::Commerce.price }
    state  { Order::BUILDING }
    building_at { Time.zone.now }
    user
    address

    trait :canceled do
      state  { Order::CANCELED }
    end
  end
end
