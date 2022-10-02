# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## usersテーブル
|Column|Type|Options|
|------|----|-------|
|lastname|string|null: false|
|firstname|string|null: false|
|lastname_reading|string|null: false|
|firstname_reading|string|null: false|
|birthday|date|null: false|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|encrypted_password|string|null: false|

### Association
- has_many :items
- has_many :purchases


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|item|string|null: false|
|explanation|text|null: false|
|category_id|integer|null: false|
|condition_id|integer|null: false|
|shipping_fee_id|integer|null: false|
|prefecture_id|integer|null: false|
|days_to_ship_id|integer|null: false|
|price|integer|null: false|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one :purchase


## purchasesテーブル
|Column|Type|Options|
|------|----|-------|
|item|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping


## shippingsテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string|
|phone_number|string|null: false|
|purchase|references|null: false, foreign_key: true|

### Association
- belongs_to :purchase