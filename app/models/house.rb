# frozen_string_literal: true

# rubocop:disable Style/Documentation

class House < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :user
  has_many :images, dependent: :destroy
  has_one :address, dependent: :destroy
  has_one :city, through: :address
  has_one :country_code, through: :address

  accepts_nested_attributes_for :address

  validates :price_per_night, :price_per_week, :price_per_month,
            :bathrooms, :bedrooms, numericality: { only_integer: true, allow_nil: true }
  validates :admin_approved, :paid, inclusion: { in: [true, false] }
  validates :description, presence: true, length: { maximum: 500 }

  scope :in_city, ->(city_name) { joins(:address).where(addresses: { city: city_name }) }
  scope :in_country_code, ->(country_code) { joins(:address).where(addresses: { country_code: }) }

  scope :paid_and_admin_approved, -> { where(paid: true, admin_approved: true) }

  def formatted_updated_at
    time_ago_in_words(updated_at.to_time).titleize
  end

  def latitude
    address&.geolocation&.y
  end

  def longitude
    address&.geolocation&.x
  end

  def owner
    User.find(user_id)
  end

  def owner_id
    User.find(user_id).id
  end

  def owner_profile_picture
    user = User.find(user_id)
    ProfilePicture.find_by(user_id: user.id) ? ProfilePicture.find_by(user_id: user.id).url : ''
  end

  def cover_image
    images&.first&.url || ''
  end

  def address
    Address.find_by(house_id: id)
  end

  def selling_commission_percentage
    for_sale_selling_commission_percentage.floor(2)
  end

  def active
    paid && admin_approved && published
  end

  def buying_commission_percentage
    for_sale_buying_commission_percentage.floor(2)
  end

  def total_commission_percentage
    for_sale_total_commission_percentage.floor(1)
  end

  def selling_commission
    (selling_commission_percentage * for_sale_price) / 100
  end

  def buying_commission
    (buying_commission_percentage * for_sale_price) / 100
  end
end
# rubocop:enable Style/Documentation
