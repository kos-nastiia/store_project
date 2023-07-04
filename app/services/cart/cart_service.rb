class Cart::CartService
  attr_reader :current_session, :params, :product, :product_balance
  attr_accessor :notice

  def initialize(current_session, params = {})
    @current_session = current_session
    @params = params
  end

  def call
    case params[:update_action]

    when 'buy'
      add_product
      "Product added to cart."

    when 'change'
      change_amount
      "Amount was changed"

    when 'delete'
      delete_product
      "Product was removed"
    end
  end

  def items
    Product.find(current_session[:products].keys)
  end

  def sum
    items.map { |product| current_session[:products][product.id.to_s] * product.price }.sum
  end

  private

  def add_product
    set_product

    if current_session[:products].key?(product[:id])
      amount = amount_greater_balance? ? product_balance: product[:amount]
      current_session[:products][product[:id]] += amount
    else
      @current_session[:products].merge!(product[:id] => product[:amount])
    end
  end

  def change_amount
    set_product

    current_session[:products][product[:id]] = product[:amount]
  end

  def delete_product
    current_session[:products].delete(params[:id])
  end

  def set_product
    @product = {
      id: params[:id],
      amount: params[:amount].to_i
    }

    @product_balance = Product.find(product[:id].to_i).balance

    product[:amount] = product_balance if product_balance < product[:amount]
  end
end
