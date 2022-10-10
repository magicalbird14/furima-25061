FactoryBot.define do

  factory :user do
    nickname              {"abc"}
    email                 {"kkk@gmail.com"}
    password              {"0000aaaa"}
    password_confirmation {"0000aaaa"}
    lastname              {"あいうえお鈴木"}
    firstname             {"かきくけこ太郎"}
    lastname_reading      {"アイウエオ"}
    firstname_reading     {"カキクケコ"}
    birthday              {"19300101"}
  end

end