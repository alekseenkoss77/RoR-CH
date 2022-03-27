FactoryBot.define do
  factory :order_item do
    state  { OrderItem::SOLD }
    quantity { 1 }
    price { Faker::Commerce.price }
    order
  end
end
