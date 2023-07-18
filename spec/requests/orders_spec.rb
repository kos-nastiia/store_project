require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let!(:order) { create(:order) }
  let!(:product) { create(:product) }

  let(:valid_attributes) { { order: attributes_for(:order) } }
  let(:invalid_attributes) { { order: attributes_for(:order, :invalid_order) } }

  describe "GET /show" do
    it 'returns order' do
      get order_path(order)

      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'sets products and create a new order' do
      patch add_product_in_cart_path(product)
      get new_order_path

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new order and redirects to order page' do
        patch add_product_in_cart_path(product)

        expect { post orders_path, params: valid_attributes }.to change(Order, :count).by(1)

        expect(response).to redirect_to(order_path(Order.last))
        expect(flash[:notice]).to eq('Order was successfully created.')

        expect(session[:products]).to be_nil
      end
    end

    context 'with invalid order parameters' do
      it 'does not create a new order and sets the status code to unprocessable_entity' do
        patch add_product_in_cart_path(product)

        post orders_path, params: invalid_attributes

        expect(response).to be_unprocessable
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the order and redirects to the products list' do
      expect { delete order_path(order) }.to change(Order, :count).by(-1)

      expect(response).to redirect_to(products_path)
      expect(flash[:notice]).to eq("Order successfully destroyed.")
    end
  end
end
