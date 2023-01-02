class Item < ApplicationRecord
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :item
    validates :explanation
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :days_to_ship_id
    validates :price
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  validates :price,
            # 対象の値がblank? => trueの場合にバリデーションをスキップします。
            allow_blank: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days_to_ship

  belongs_to :user
  has_one :purchase, dependent: :destroy
end
