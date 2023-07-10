require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let!(:product) { create(:product) }

  describe "GET /cart" do
    it "renders the empty cart page" do
      get cart_index_path

      expect(response).to be_successful
    end

    it "renders the cart page with product" do
      patch add_product_in_cart_path(product)
      get cart_index_path

      expect(response).to be_successful
      expect(response.body).to include(product.title)
    end
  end

  describe "PATCH #buy" do
    it "adds the product to the cart" do
      patch add_product_in_cart_path(product)

      expect(session.dig(:products, product.id.to_s)).to be_present
    end

    it "redirects back to the previous page" do
      patch add_product_in_cart_path(product)

      expect(response).to redirect_to(request.referrer || root_path)
    end
  end

  describe "PATCH #change_amount" do
    let(:amount) { 3 }

    it "changes the product amount in the cart" do
      patch change_amount_product_in_cart_path(product), params: { amount: }
      expect(session.dig(:products, product.id.to_s)).to eq(amount)
    end

    it "redirects back to the previous page" do
      patch change_amount_product_in_cart_path(product), params: { amount: }
      expect(response).to redirect_to(request.referrer || root_path)
    end
  end
end
