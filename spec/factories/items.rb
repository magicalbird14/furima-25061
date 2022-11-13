FactoryBot.define do
  factory :item do
    item             {Faker::Lorem.word}
    explanation      {Faker::Lorem.paragraph}

    # Faker::Config.locale  = :category
    # category         {Faker::Lorem.word}

    category_id      {Faker::Number.between(from: 2, to: 11)}
    condition_id     {Faker::Number.between(from: 2, to: 7)}
    shipping_fee_id  {Faker::Number.between(from: 2, to: 3)}
    # address = Gimei.address
    # prefecture_id    {address.prefecture.kanji}
    prefecture_id    {Faker::Number.between(from: 2, to: 48)}
    days_to_ship_id  {Faker::Number.between(from: 2, to: 4)}
    price            {Faker::Number.between(from: 300, to: 9999999)}

    association :user
  end
end
