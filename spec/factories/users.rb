FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { "#{Faker::Internet.password(min_length: 4)}1a" }
    password_confirmation { password }

    japanese_user = Gimei.name
    lastname              { japanese_user.last.kanji }
    firstname             { japanese_user.first.kanji }
    lastname_reading      { japanese_user.last.katakana }
    firstname_reading     { japanese_user.first.katakana }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 70) }
  end
end
