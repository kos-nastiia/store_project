module Cart
  class CartService
  attr_reader :current_session, :params, :product, :product_balance

  def initialize(current_session, params = {})
    @current_session = current_session
    @params = params
  end

  def products
    current_session[:products].keys.map { |id| Product.find(id) }
  end
  
  def sum
    products.map { |product| current_session[:products][product.id.to_s] * product.price }.sum
  end

  def add_to_cart
    set_product

    if current_session[:products].key?(product[:id])
      increase_product_amount
    else
      current_session[:products][product[:id]] = product[:amount]
    end
  end

  def update_product_amount
    set_product

    if current_session[:products].key?(product[:id])
      current_session[:products][product[:id]] = product[:amount]
    end
  end

  def remove_from_cart
    current_session[:products].delete(product[:id])
  end

  def calculate_cart_total
    total = 0

    current_session[:products].each do |product_id, amount|
      product = Product.find_by(id: product_id)
      next unless product

      total += product.price * amount
    end

    total
  end

  private

  def set_product
    @product = {
      id: params[:id],
      amount: params[:amount].to_i
    }

    @product_balance = Product.find(product[:id].to_i).balance
    product[:amount] = 1 if product[:amount].blank? || product[:amount] <= 0
    product[:amount] = product_balance if product_balance < product[:amount]
  end

  def increase_product_amount
    current_session[:products][product[:id]] = product[:amount]
    current_session[:products][product[:id]] = product_balance if amount_greater_than_balance?
  end

  def amount_greater_than_balance?
    product_balance && (product[:amount] + current_session[:products][product[:id]]) > product_balance
  end
end
end
