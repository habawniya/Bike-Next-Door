class BikesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_bike, only: [:show, :edit, :update, :destroy]

  def index
    @bikes = current_user.owner? ? current_user.bikes : Bike.all

    if params[:start_date].present? && params[:end_date].present?
      @bikes = @bikes.available_between(params[:start_date].to_date, params[:end_date].to_date)
    end

    if params[:search].present?
     @bikes = @bikes.where("(name)LIKE ?", "%#{params[:search]}%")
    end

    if params[:sort] == "low_to_high"
      @bikes = @bikes.order(price_per_day: :asc)
    elsif params[:sort] == "high_to_low"
      @bikes = @bikes.order(price_per_day: :desc)
    
    elsif params[:sort] == "none"
    @bikes = @bikes.order(:price).reorder(created_at: :asc)
    end
  end


  def show
  end

  def new
    @bike = current_user.bikes.build
  end

  def create
    @bike = current_user.bikes.build(bike_params)
    if @bike.save
      redirect_to @bike, notice: "Bike created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @bike.update(bike_params)
      redirect_to @bike, notice: "Bike updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @bike.destroy
    redirect_to bikes_path, notice: "Bike deleted successfully."
  end


  private

  def set_bike
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.require(:bike).permit(:name, :engine, :start_power, :model_year, :price_per_day, :image)
  end
  
end
