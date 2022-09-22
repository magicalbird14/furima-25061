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
|name|string|null: false|
|name_reading|string|null: false|
|email|text|null: false, unique: true|
|encrypted_password|text|null: false|

### Association
- has_many :items
- has_many :purchase


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|image|string|
|price|integer|null: false|
|users_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :users
- has_one :purchase


## purchaseテーブル
|Column|Type|Options|
|------|----|-------|
|items_id|integer|null: false, foreign_key: true|
|users_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :users
- belongs_to :items
- has_one :shipping


## shippingテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string|null: false|
|purchase|integer|null: false, foreign_key: true|

### Association
- belongs_to :purchase