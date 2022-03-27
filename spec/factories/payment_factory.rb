FactoryBot.define do
  factory :payment do
    number { SecureRandom.hex(5) }
    state  { nil }
    amount { Faker::Commerce.price }
    payment_type { Payment::CREDIT_CARD }
    order
  end
end
