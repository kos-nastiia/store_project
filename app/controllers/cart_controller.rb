class CartController < ApplicationController
  before_action :init_cart, only: :update

  def index
    @cart = Cart::Manager.new(session, cart_params)
  end

  def update
    notice = Cart::Manager.new(session, params).call

    redirect_back fallback_location: root_path, notice: notice
  end

  def destroy
    session.delete(:products)

    redirect_to products_path, notice: "Cart was cleaned"
  end

  private

  def init_cart
    session[:products] = {} if session[:products].blank?
  end

  def cart_params
    params.permit(:id, :amount, :update_action)
  end
end
