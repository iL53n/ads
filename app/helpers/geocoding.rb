module Geocoding
  def set_coordinates!(ad)
    coordinates = geocoding_service.geocode(ad.city)
    return if coordinates.blank?

    ad.lat, ad.lon = coordinates
    ad.save
  end

  private

  def geocoding_service
    @geocoding_service ||= GeocodingService::Client.new
  end
end
