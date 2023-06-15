require 'rails_helper'

RSpec.describe "Products", type: :request do
  let!(:product) { create(:product) }

  let(:new_attributes) { { product: attributes_for(:product) } }
  let(:valid_attributes) { { product: attributes_for(:product) } }
  let(:invalid_attributes) { { product: attributes_for(:product, :invalid) } }

  describe "GET /index" do
    it "returns http success" do
      get products_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get product_path(product)
      expect(response).to render_template(:show)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_product_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new product" do
        expect { post products_path, params: valid_attributes }.to change(Product, :count).by(1)
      end

      it "redirects to the created product" do
        post products_path, params: valid_attributes 
        expect(response).to redirect_to(Product.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new product" do
        expect { post products_path, params: invalid_attributes }.to_not change(Product, :count)
      end

      it "sets the status code to unprocessable_entity" do
        post products_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_product_path(product)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested product" do
        patch product_path(product), params: { product: new_attributes[:product] }
        product.reload
        expect(product.title).to eq(new_attributes[:product][:title])
      end

      it "redirects to the updated product" do
        patch product_path(product), params: { product: new_attributes[:product] }
        expect(response).to redirect_to(product)
      end
    end

    context "with invalid parameters" do
      it "sets the status code to unprocessable_entity" do
        patch product_path(product), params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested product" do
      expect { delete product_path(product) }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      delete product_path(product)

      expect(response).to redirect_to(products_path)
    end
  end

end
