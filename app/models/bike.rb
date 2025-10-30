class Bike < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :bike_unavailable_dates, dependent: :destroy
  has_many :bookings, dependent: :destroy


  scope :available_between, ->(start_date, end_date) {
    all.select { |b| b.available_for?(start_date, end_date) }
  }

  def available_for?(start_date, end_date)  
  requested_dates = (start_date..end_date).to_a

  active_bookings = bookings.where(status: ["booked"])

  booked_dates = active_bookings.flat_map { |b| (b.start_date..b.end_date).to_a }

  unavailable_dates = bike_unavailable_dates.pluck(:date)

  (requested_dates & booked_dates).empty? && (requested_dates & unavailable_dates).empty?
 end
end




