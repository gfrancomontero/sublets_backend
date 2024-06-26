# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  house_id   :bigint
#  street     :string
#  city       :string
#  state      :string
#  zip_code   :string
#  country_code    :string
#  latlong    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_addresses_on_house_id  (house_id)
#
# Address Model
#
# Represents an address associated with a house listing in the application.
class Address < ApplicationRecord
  require 'activerecord-postgis-adapter'
  require 'rgeo-activerecord'

  belongs_to :house
  before_validation :downcase_country_code
  before_validation :snakecase_downcase_city
  # If you have an address method that compiles a full address, use it here.
  # Otherwise, this is just to ensure geocoder's methods are injected.
  geocoded_by :full_address

  private

  def full_address
    [street, city, state, country_code].compact.join(', ')
  end

  def snakecase_downcase_city
    self.city = city.downcase.gsub(' ', '_') if city.present?
  end

  def downcase_country_code
    self.country_code = country_code.downcase if country_code.present?
  end
end
