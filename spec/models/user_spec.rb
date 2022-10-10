require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    it "1必須項目が正しく入力されていれば登録ができること" do
      user = build(:user)
      expect(user).to be_valid
    end
    it "2ニックネームが必須であること。" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
    it "3メールアドレスが必須であること。" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "4メールアドレスが一意性であること。" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end
    it "5メールアドレスは、@を含む必要があること。" do
      user = build(:user, email: "abc.co.jp")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
    it "6passwordが空では登録できない" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    it "7パスワードは、6文字以上での入力が必須であること" do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
    it "8パスワードは、半角英数字混合での入力が必須であること-全角では登録できない" do
      user = build(:user, password: "00000０", password_confirmation: "00000０")
      user.valid?
      expect(user.errors[:password]).to include("is invalid. Input half-width characters.")
    end
    it "9パスワードは、半角英数字混合での入力が必須であること-半角英数のみでは登録できない" do
      user = build(:user, password: "abcdef", password_confirmation: "abcdef")
      user.valid?
      expect(user.errors[:password]).to include("is invalid. Input half-width characters.")
    end
    it "10パスワードは、半角英数字混合での入力が必須であること-半角数字のみでは登録できない" do    
    user = build(:user, password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user.errors[:password]).to include("is invalid. Input half-width characters.")
    end
    it "11パスワードとパスワード（確認）は、値の一致が必須であること" do
      user = build(:user, password: "000000", password_confirmation: "111111")
      user.valid?
      expect(user.errors[:password]).to include("is invalid. Input half-width characters.")
    end
    it "12お名前(全角)は、名字がそれぞれ必須であること" do
      user = build(:user, lastname: nil)
      user.valid?
      expect(user.errors[:lastname]).to include("can't be blank")
    end
    it "13お名前(全角)は、名前がそれぞれ必須であること" do
      user = build(:user, firstname: nil)
      user.valid?
      expect(user.errors[:firstname]).to include("can't be blank")
    end
    it "14お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること-アルファベット不可" do
      user = build(:user, firstname: "taro")
      user.valid?
      expect(user.errors[:firstname]).to include("is invalid. Input full-width characters.")
    end
    it "15お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること-アルファベット不可" do
      user = build(:user, lastname: "suzuki")
      user.valid?
      expect(user.errors[:lastname]).to include("is invalid. Input full-width characters.")
    end
    it "16お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること-数字不可" do
      user = build(:user, firstname: "３９")
      user.valid?
      expect(user.errors[:firstname]).to include("is invalid. Input full-width characters.")
    end
    it "17お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること-数字不可" do
      user = build(:user, lastname: "１２３")
      user.valid?
      expect(user.errors[:lastname]).to include("is invalid. Input full-width characters.")
    end
    it "18お名前カナ(全角)は、名字がそれぞれ必須であること。" do
      user = build(:user, lastname_reading: nil)
      user.valid?
      expect(user.errors[:lastname_reading]).to include("can't be blank")
    end
    it "19お名前カナ(全角)は、名前がそれぞれ必須であること。" do
      user = build(:user, firstname_reading: nil)
      user.valid?
      expect(user.errors[:firstname_reading]).to include("can't be blank")
    end
    it "20お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー平仮名不可" do
      user = build(:user, lastname_reading: "すずき")
      user.valid?
      expect(user.errors[:lastname_reading]).to include("is invalid. Input full-width katakana characters.")
    end
    it "21お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー平仮名不可" do
      user = build(:user, firstname_reading: "たろう")
      user.valid?
      expect(user.errors[:firstname_reading]).to include("is invalid. Input full-width katakana characters.")
    end
    it "22お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー漢字不可" do
      user = build(:user, lastname_reading: "鈴木")
      user.valid?
      expect(user.errors[:lastname_reading]).to include("is invalid. Input full-width katakana characters.")
    end
    it "23お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー漢字不可" do
      user = build(:user, firstname_reading: "太郎")
      user.valid?
      expect(user.errors[:firstname_reading]).to include("is invalid. Input full-width katakana characters.")
    end
    it "24お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー半角不可" do
      user = build(:user, lastname_reading: "ｽｽﾞｷ")
      user.valid?
      expect(user.errors[:lastname_reading]).to include("is invalid. Input full-width katakana characters.")
    end
    it "25お名前カナ(全角)は、全角（カタカナ）での入力が必須であることー半角不可" do
      user = build(:user, firstname_reading: "ﾀﾛｳ")
      user.valid?
      expect(user.errors[:firstname_reading]).to include("is invalid. Input full-width katakana characters.")
    end
    it "26生年月日が必須であること。" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end
  end
end
