FactoryBot.define do
  factory :order_detail do
    quantity 10
    price 1000
    total_price 10000
    order
    product
  end
end
