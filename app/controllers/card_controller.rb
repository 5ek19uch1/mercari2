class CardController < ApplicationController
  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay #payjpとCardのデータベース作成
    Payjp.api_key = "sk_test_cfd505a323b7a500937468a7"
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れたけどなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to '/signup/card'
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = "sk_test_cfd505a323b7a500937468a7"
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
    redirect_to card_add_path 
  end

def show #Cardのデータpayjpに送り情報を取り出します
  @user = current_user
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to card_add_path 
    else
      Payjp.api_key = "sk_test_cfd505a323b7a500937468a7"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end


  def add
  end

  def buy #クレジット購入アクション
    if cards.blank?
      redirect_to action: "show"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      @item = Item.find(params[:items_id])
      # 購入した際の情報を元に引っ張ってくる
      card = current_user.credit_card
      # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      Payjp.api_key = "sk_test_cfd505a323b7a500937468a7"
      # キーをセットする(環境変数においても良い)
      Payjp::Charge.create(
      amount: @Item.price,        #支払金額
      customer: card.customer_id, #顧客ID
      currency: 'jpy',            #日本円
      )
      # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
      if @product.update(status: 1, buyer_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to controller: "products", action: 'show'
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: "products", action: 'show'
      end
    end
  end




end
