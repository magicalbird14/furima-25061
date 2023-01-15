class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_id, only: [:index, :create]

  def index
    @item_purchase = ItemPurchase.new
    redirect_to root_path if @item.purchase.present? || current_user.id == @item.user_id
  end

  def create
    @item_purchase = ItemPurchase.new(purchase_params)
    if @item_purchase.valid?
      @item_purchase.save
      pay_item
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:item_purchase).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :house_number,
      :building_name,
      :phone_number
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: @item_purchase.token,
      currency: 'jpy'
    )
  end

  def item_id
    @item = Item.find(params[:item_id])
  end
end
