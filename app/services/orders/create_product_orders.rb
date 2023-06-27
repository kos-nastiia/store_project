class Orders::CreateProductOrders
  attr_reader :products_hash, :order

  def initialize(products_hash, order)
    @products_hash = products_hash
    @order = order
  end

  def call
    products_hash.each do |product_id, amount|
      product = Product.find(product_id)
      amount = [amount, product.balance].min

      order.product_orders.create(product_id:, amount:)
    end
  end
end
