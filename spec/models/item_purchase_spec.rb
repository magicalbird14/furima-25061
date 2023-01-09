require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
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
      it '2-1電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。携帯電話11桁' do
        @item_purchase.phone_number = '09012345678'
        expect(@item_purchase).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '3user_idが空だと登録できない。' do
        @item_purchase.user_id = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "User can't be blank"
      end
      it '4item_idが空だと登録できない。' do
        @item_purchase.item_id = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "Item can't be blank"
      end
      it '5クレジットカード情報のtokenが必須であること。' do
        @item_purchase.token = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "Token can't be blank"
      end
      it '6郵便番号が必須であること。' do
        @item_purchase.postal_code = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "Postal code can't be blank"
      end
      it '7郵便番号が「3桁ハイフン4桁」の半角文字列のみであること。ハイフンなし' do
        @item_purchase.postal_code = '1231234'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it '8郵便番号が「3桁ハイフン4桁」の半角文字列のみであること。全角' do
        @item_purchase.postal_code = '１２３１２３４'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it '9都道府県が必須であること。' do
        @item_purchase.prefecture_id = 1
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '10市町村が必須であること。' do
        @item_purchase.city = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "City can't be blank"
      end
      it '11番地が必須であること。' do
        @item_purchase.house_number = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "House number can't be blank"
      end
      it '12電話番号が必須であること。' do
        @item_purchase.phone_number = nil
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include "Phone number can't be blank"
      end
      it '13電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。9桁' do
        @item_purchase.phone_number = '012345678'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '14電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。12桁' do
        @item_purchase.phone_number = '012345678901'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '15電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。ハイフン' do
        @item_purchase.phone_number = '0123-45-678'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '16電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。全角' do
        @item_purchase.phone_number = '０９０１１１１２２２２'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '17電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。アルファベット' do
        @item_purchase.phone_number = '0901111222a'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '18電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。先頭0始まり以外' do
        @item_purchase.phone_number = '1234567890'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
      it '19電話番号が10桁以上11桁以内の半角数値のみ保存可能なこと。携帯電話存在しない番号' do
        @item_purchase.phone_number = '02012345678'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include 'Phone number is invalid'
      end
    end
  end
end
