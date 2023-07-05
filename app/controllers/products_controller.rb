class ProductsController < ApplicationController
  def index
    @products = collection
  end

  def show
    @product = resource
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = resource
  end

  def update
    @product = resource

    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = resource

    @product.destroy

    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :balance)
  end

  def collection
    Product.ordered
  end

  def resource
    collection.find(params[:id])
  end
  
end
