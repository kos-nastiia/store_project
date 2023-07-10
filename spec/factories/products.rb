FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 0.01..1000.0) }
    balance { Faker::Number.non_zero_digit }
  end

  trait :invalid_product do
    title { nil }
    description { nil }
    balance { nil }
  end
end
