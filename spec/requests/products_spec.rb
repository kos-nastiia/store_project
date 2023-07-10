require 'rails_helper'

RSpec.describe "Products", type: :request do
  let!(:product) { create(:product) }

  let(:valid_attributes) { { product: attributes_for(:product) } }
  let(:invalid_attributes) { { product: attributes_for(:product, :invalid_product) } }

  describe "GET /index" do
    it "returns products" do
      get products_path

      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "returns product" do
      get product_path(product)

      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "create new product" do
      get new_product_path

      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new product and redirects to the created product" do
        expect { post products_path, params: valid_attributes }.to change(Product, :count).by(1)
     
        expect(response).to redirect_to(product_path(Product.last))
        expect(flash[:notice]).to eq("Product was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new product and sets the status code to unprocessable_entity" do      
        post products_path, params: invalid_attributes

        expect(response).to be_unprocessable
      end
    end
  end

  describe "GET /edit" do
    it "returns successful response" do
      get edit_product_path(product)

      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the product and redirects to the updated product" do
        patch product_path(product), params: valid_attributes
        
        expect(product.reload.title).to eq(valid_attributes[:product][:title])
        expect(response).to redirect_to(product)
        expect(flash[:notice]).to eq("Product was successfully updated.")
      end
    end

    context "with invalid parameters" do
      it "sets the status code to unprocessable_entity" do
        patch product_path(product), params: invalid_attributes

        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the product and redirects to the products list" do
      expect { delete product_path(product) }.to change(Product, :count).by(-1)
 
      expect(response).to redirect_to(products_path)
      expect(flash[:notice]).to eq("Product was successfully destroyed.")
    end
  end
end
