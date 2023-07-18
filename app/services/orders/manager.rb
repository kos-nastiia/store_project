class Orders::Manager

  def initialize(cart, order, current_session)
    @cart = cart
    @order = order
    @current_session = current_session
  end

  def call
    product_orders = @cart.map do |product_id, amount|
      { product_id: product_id.to_i, amount: amount, order_id: @order.id }
    end

    ProductOrder.insert_all(product_orders)

    @order.products.each do |product|
      product.update(balance: product.balance - product.product_orders.where(order_id: @order.id).sum(:amount))
    end

    @current_session.delete(:products)
  end
end
