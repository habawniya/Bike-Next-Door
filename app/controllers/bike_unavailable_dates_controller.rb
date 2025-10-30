class BikeUnavailableDatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bike

  def create 
    @unavailable_date = @bike.bike_unavailable_dates.create(date: params[:date])
    if @unavailable_date.save
      redirect_to @bike, notice: "Date marked as unavailable."
    else
      redirect_to @bike, alert: "Could not mark date as unavailable "
    end
  end

  def destroy
    @unavailable_date = @bike.bike_unavailable_dates.find(params[:id])
    @unavailable_date.destroy
    redirect_to @bike, notice: "Unavailable date removed."
  end

  private

  def set_bike
    @bike = Bike.find(params[:bike_id])
  end
end
