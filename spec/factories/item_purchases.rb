FactoryBot.define do
  factory :item_purchase do
    token                 { "tok_#{Faker::Lorem.characters(number: 28)}" }
    postal_code           { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id         { Faker::Number.between(from: 2, to: 48) }
    city                  { Gimei.city.kanji }
    # city                  { Faker::Address.street_name }
    house_number          { Faker::Address.postcode }
    building_name         { Faker::Address.mail_box }
    phone_number          { Faker::Number.leading_zero_number(digits: 10) }
  end
end
