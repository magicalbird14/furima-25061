require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '内容に問題ない場合' do
      it '1必須項目が正しく入力されていれば登録ができること' do
        expect(@user).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '2ニックネームが必須であること。' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it '3メールアドレスが必須であること。' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it '4メールアドレスが一意性であること。' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
      it '5メールアドレスは、@を含む必要があること。' do
        @user.email = 'abc.co.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it '6passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it '7パスワードは、6文字以上での入力が必須であること' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it '8パスワードは、半角英数字混合での入力が必須であること-全角では登録できない' do
        @user.password = '00000０'
        @user.password_confirmation = '00000０'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid. Input half-width characters.'
      end
      it '9パスワードは、半角英数字混合での入力が必須であること-半角英数のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid. Input half-width characters.'
      end
      it '10パスワードは、半角英数字混合での入力が必須であること-半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid. Input half-width characters.'
      end
      it '11パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = '000000'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it '12お名前(全角)は、名字がそれぞれ必須であること' do
        @user.lastname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Lastname can't be blank"
      end
      it '13お名前(全角)は、名前がそれぞれ必須であること' do
        @user.firstname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname can't be blank"
      end
      it '14お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること-アルファベット不可' do
        @user.firstname = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Firstname is invalid. Input full-width characters.'
      end
      it '15お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること-アルファベット不可' do
        @user.lastname = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Lastname is invalid. Input full-width characters.'
      end
      it '16お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること-数字不可' do
        @user.firstname = '３９'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Firstname is invalid. Input full-width characters.'
      end
      it '17お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること-数字不可' do
        @user.lastname = '１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Lastname is invalid. Input full-width characters.'
      end
      it '18お名前カナ(全角)は、名字がそれぞれ必須であること。' do
        @user.lastname_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Lastname reading can't be blank"
      end
      it '19お名前カナ(全角)は、名前がそれぞれ必須であること。' do
        @user.firstname_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname reading can't be blank"
      end
      it '20お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー平仮名不可' do
        @user.lastname_reading = 'すずき'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lastname reading is invalid. Input full-width katakana characters.')
      end
      it '21お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー平仮名不可' do
        @user.firstname_reading = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname reading is invalid. Input full-width katakana characters.')
      end
      it '22お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー漢字不可' do
        @user.lastname_reading = '鈴木'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lastname reading is invalid. Input full-width katakana characters.')
      end
      it '23お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー漢字不可' do
        @user.firstname_reading = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname reading is invalid. Input full-width katakana characters.')
      end
      it '24お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー半角不可' do
        @user.lastname_reading = 'ｽｽﾞｷ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lastname reading is invalid. Input full-width katakana characters.')
      end
      it '25お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー半角不可' do
        @user.firstname_reading = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname reading is invalid. Input full-width katakana characters.')
      end
      it '26生年月日が必須であること。' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
