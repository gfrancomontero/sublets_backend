# frozen_string_literal: true

class HousesController < ApplicationController
  # GET /houses
  def index
    per_page = params[:per_page] || 20
    houses = House.page(params[:page]).per(per_page)
    render json: houses_json(houses)
  end

  private

  def houses_json(houses)
    houses.as_json(
      only: %i[title price_per_night price_per_week price_per_month subtitle description bedrooms bathrooms id general_address],
      include: [
        { images: { only: %i[url position] } },
        { user: { only: %i[name phone_number email] } },
        { address: { only: %i[neighborhood city state zip_code] } }
      ]
    )
  end
end
