class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
      
  has_many :bikes, dependent: :destroy

  has_many :cart_items, dependent: :destroy
  has_many :bookings, dependent: :destroy

  def owner?
    role == 1
  end

  def renter?
    role == 0
  end
end
