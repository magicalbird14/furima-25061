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
|birthday|integer|null: false|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|encrypted_password|string|null: false|

### Association
- has_many :items
- has_many :purchases


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|explanation|string|null: false|
|category|integer|null: false|
|condition|integer|null: false|
|Shipping_charges|integer|null: false|
|prefecture|integer|null: false|
|Days_to_Ship|integer|null: false|
|price|integer|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one :purchase


## purchasesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping


## shippingsテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|string|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string|
|phone_number|integer|null: false|
|purchase_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :purchase