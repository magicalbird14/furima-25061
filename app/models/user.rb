class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         with_options presence: true do
          # 半角英字数字のみ許可する
          # validates :nickname, format: {with: /\A[a-z0-9]+\z/i, message: "is invalid. Input half-width characters."}
          validates :nickname
          validates :lastname
          validates :firstname
          validates :lastname_reading
          validates :firstname_reading
          validates :email, format: { with: /\A[\w+-.]+@[a-z\d-]+(.[a-z\d-]+)*.[a-z]+\z/i }
          validates :password
          validates :birthday
        end

        # ひらがな、カタカナ、漢字のみ許可する
        with_options format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input full-width characters."} do
          validates :lastname
          validates :firstname
        end

        # カタカナのみ許可する
        with_options format: {with: /\A[ァ-ヶー]+\z/, message: "is invalid. Input full-width katakana characters."} do
          validates :lastname_reading
          validates :firstname_reading
        end
        
        #半角英数字を両方含む
        with_options  format: {with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "is invalid. Input half-width characters."} do
          validates :password
        end



  class Photo < ActiveRecord::Base
    has_many :items
    has_many :purchases
  end
end

