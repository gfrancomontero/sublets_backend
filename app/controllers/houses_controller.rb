class HousesController < ApplicationController
  # GET /houses
  def index
    per_page = params[:per_page] || 20
    sort_column = params[:sort_by] || 'available_from'
    sort_order = params[:order] || 'asc'

    if House.column_names.include?(sort_column) && %w[asc desc].include?(sort_order.downcase)
      houses = House.order("#{sort_column} #{sort_order}").page(params[:page]).per(per_page)
    else
      houses = House.order('available_from asc').page(params[:page]).per(per_page)
    end

    render json: houses_json(houses)
  end

  private

  def houses_json(houses)
    houses.map do |house|
      house.attributes.slice('title', 'price_per_night', 'price_per_week', 'price_per_month', 'subtitle', 'description', 'bedrooms', 'bathrooms', 'id', 'general_address').merge(
        available_from: house.available_from.strftime('%b %e, %Y'),
        available_until: house.available_until.strftime('%b %e, %Y'),
        images: house.images.as_json(only: %i[url position]),
        user: house.user.as_json(only: %i[name phone_number email]),
        address: house.address.as_json(only: %i[neighborhood city state zip_code]).merge(
          longitude: house.longitude,
          latitude: house.latitude
        )
      )
    end
  end
end
