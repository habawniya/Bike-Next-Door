class CartItemsController < ApplicationController
    before_action :authenticate_user!

  def index
    @cart_items = current_user.cart_items.includes(:bike)
  end

  def create
    @bike = Bike.find(params[:bike_id])
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
     
    if !@bike.available_for?(start_date, end_date)
      redirect_to bikes_path, alert: "Bike not available for selected dates"
      return
    end
     
    @cart_item = current_user.cart_items.find_or_initialize_by(bike: @bike)
    @cart_item.start_date = start_date
    @cart_item.end_date = end_date

    if @cart_item.save
      redirect_to cart_items_path, notice: "Bike added to cart!"
    else
      redirect_to bikes_path, alert: @cart_item.errors.full_messages.join(", ")
    end
  end

  def destroy
    @cart_item = current_user.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: "Item removed from cart."
  end

end
