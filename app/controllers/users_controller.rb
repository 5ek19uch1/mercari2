class UsersController < ApplicationController
  before_action :authenticate_user!
# ユーザーマイページ（岸田）
  def index
    @category_parents = Category.where(ancestry: nil)
  end
# ログアウト画面（山添）
 
# 中島エリア（不可侵領域）
  def credit_new
  end
# ユーザープロフィール編集ページ(山添)
  def show
    @user = User.find(params[:id])

  end

  def logout
  end

  def phone_confirmation
  end

  def profile
  end

#　商品状態　出品中（山添）
  def status_selling
    @item = Item.where(status:'1').limit(15)
    @stop = Item.where(status:'4').limit(15)
  end
#　商品状態　取引中（山添）
  def status_trading
    @item = Item.where(status:'2').limit(15)
  end
#　商品状態　売り切れ（山添）
  def status_sold
    @item = Item.where(status:'3').limit(15)
  end
#未使用
  # def destroy
  #   user = user.find(params[:id])
  #   if user.user_id == current_user.id
  #     user.destroy
  #   end
  #   redirect_to action: :index
  # end
# ユーザー本人確認ページ（関口）
  def regist
    @user = User.find(params[:id])
    @addresses = @user.addresses.includes(:user)
  end

  def email_password
  end

  def products_details
    @user = User.find(params[:id])
    @items = Item.all
  end




end
