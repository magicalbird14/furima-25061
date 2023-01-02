require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  before do
    @item = FactoryBot.create(:item)
    @user = create(:user)
    @item_purchase = FactoryBot.build(:item_purchase, item_id: @item.id, user_id: @user.id)
    sleep 0.1
  end

  describe '商品登録' do
    context '内容に問題ない場合' do
      it '1必須項目が正しく入力されていれば登録ができること' do
        expect(@item_purchase).to be_valid
      end
      it '2建物名は任意であること。' do
        @item_purchase.building_name = nil
        expect(@item_purchase).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '3クレジットカード情報のtokenが必須であること。' do
        @item_purchase.token = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "Token can't be blank"
      end
      it '4郵便番号が必須であること。' do
        @item_purchase.postal_code = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "Postal code can't be blank"
      end
      it '5郵便番号が「3桁ハイフン4桁」の半角文字列のみであること。ハイフンなし' do
        @item_purchase.postal_code = '1231234'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it '6郵便番号が「3桁ハイフン4桁」の半角文字列のみであること。全角' do
        @item_purchase.postal_code = '１２３１２３４'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it '7都道府県が必須であること。' do
        @item_purchase.prefecture_id = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '8市町村が必須であること。' do
        @item_purchase.city = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "City can't be blank"
      end
      it '9番地が必須であること。' do
        @item_purchase.house_number = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "House number can't be blank"
      end
      it '10電話番号が必須であること。' do
        @item_purchase.phone_number = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "Phone number can't be blank"
      end
      it '11電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。9桁' do
        @item_purchase.phone_number = '012345678'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '12電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。11桁' do
        @item_purchase.phone_number = '01234567890'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '13電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。ハイフン' do
        @item_purchase.phone_number = '0123-45-678'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '14電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。全角' do
        @item_purchase.phone_number = '０９０１１１１２２２２'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '15電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。アルファベット' do
        @item_purchase.phone_number = '0901111222a'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
    end
  end
end
