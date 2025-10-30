class Booking < ApplicationRecord
  belongs_to :bike
  belongs_to :user

  validates :start_date, :end_date, presence: true

  before_save :calculate_total
  before_save :normalize_status

  private

  def calculate_total
    self.total_price = ((end_date - start_date).to_i + 1) * bike.price_per_day
  end


  def normalize_status
    self.status = status.downcase if status.present?
  end

end
