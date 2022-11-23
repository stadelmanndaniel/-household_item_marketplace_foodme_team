class Offer < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :user
  has_many_attached :photos
  validate :photo_present
  validates :name, :description, :price, :address, presence: true

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end

  private
    def photo_present
      errors.add(:photos, "you must attach at least a picture") if self.photos.empty?
    end
end
