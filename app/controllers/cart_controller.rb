class CartController < ApplicationController
  before_action :init_cart, only: :update

  def show
    @cart = Cart::CartService.new(session, cart_params)
  end

  def create
    session[:products] = {}
  end

  def update
    notice = Cart::CartService.new(session, params).call

    redirect_back fallback_location: root_path, notice: notice
  end

  def destroy
    session.delete(:products)

    redirect_to products_path, notice: "Cart was cleaned"
  end

  private

  def init_cart
    create unless session[:products].present?
  end

  def cart_params
    params.permit(:id, :amount, :update_action)
  end
end
