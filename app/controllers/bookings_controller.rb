class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:update]

  def create
    cart_items = current_user.cart_items.includes(:bike)

    if cart_items.empty?
      redirect_to bikes_path, alert: "Your cart is empty."
      return
    end

    cart_items.each do |ci|
      Booking.create!(
        user: current_user,
        bike: ci.bike,
        start_date: ci.start_date,
        end_date: ci.end_date,
        total_price: ((ci.end_date - ci.start_date).to_i + 1) * ci.bike.price_per_day,
        status: "booked"
      )
    end

    cart_items.destroy_all
    redirect_to bookings_path, notice: "Booking successful!"
  end


  def update
      @booking.update(status: "cancelled")
      redirect_to bookings_path, notice: "Booking cancelled successfully."
  end

  def index
    if current_user.owner?
    @bookings = Booking.includes(:bike, :user)
                    .where(bikes: { user_id: current_user.id })

    else
      @bookings = current_user.bookings.includes(:bike)
    end
  end



  def set_booking
    @booking = Booking.find(params[:id])
  end

end
