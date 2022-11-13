require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/青.png')
  end

  describe "商品登録" do
    context '内容に問題ない場合' do
      it "1必須項目が正しく入力されていれば登録ができること" do
        expect(@item).to be_valid
      end
   end
  
   context '内容に問題がある場合' do
    it "2出品者が必要である事。" do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "User must exist"
    end
    it "3画像が必須であること。" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Image can't be blank"
    end
    it "4商品名が必須であること。" do
      @item.item = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Item can't be blank"
    end
    it "5説明が必須であること。" do
      @item.explanation = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Explanation can't be blank"
    end
    it "6カテゴリが必須であること。" do
      @item.category_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Category can't be blank"
    end
    it "7商品の状態が必須であること。" do
      @item.condition_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Condition can't be blank"
    end
    it "8配送料の負担が必須であること。" do
      @item.shipping_fee_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Shipping fee can't be blank"
    end
    it "9発送元の地域が必須であること。" do
      @item.prefecture_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Prefecture can't be blank"
    end
    it "10発送までの日数が必須であること。" do
      @item.days_to_ship_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Days to ship can't be blank"
    end
    it "11価格が必須であること。" do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Price can't be blank"
    end
    it "12カテゴリidが1でないこと。" do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Category can't be blank"
    end
    it "13商品の状態idが1でないこと。" do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Condition can't be blank"
    end
    it "14配送料の負担idが1でないこと。" do
      @item.shipping_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Shipping fee can't be blank"
    end
    it "15発送元の地域idが1でないこと。" do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Prefecture can't be blank"
    end
    it "16発送までの日数idが1でないこと。" do
      @item.days_to_ship_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Days to ship can't be blank"
    end
    it "17価格が300未満でないこと。" do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
    end
    it "18価格が10000000以上でないこと。" do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include "Price must be less than or equal to 9999999"
    end
    it "19価格は半角数字のみであること。(全角は不可)" do
      @item.price = "５００"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is not a number"
    end
    it "20価格は半角数字のみであること。(少数は不可)" do
      @item.price = "3000.0"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price must be an integer"
    end
   end
  end

end
