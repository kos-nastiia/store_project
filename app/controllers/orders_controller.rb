class OrdersController < ApplicationController
  def index
    @orders = collection
  end
  
  def show
    @order = resource
  end

  def new
    # redirect_to products_path unless session[:products]
    @order = Order.new
  end

  def edit
    @order = resource
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      Orders::CreateProductOrders.new(session[:products], @order).call
      Products::SubtractBalance.new(@order).call
      session.delete(:products)
      redirect_to order_path(@order), notice: "Order was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update 
    @order = resourse
    if @order.update(order_params)
      redirect_to @order, notice: "Order was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order = resource
    @order.destroy
    redirect_to orders_url, notice: "Order was successfully destroyed."
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :address, :phone)
  end

  def collection
    Order.all
  end

  def resource
    collection.find(params[:id])
  end
end
