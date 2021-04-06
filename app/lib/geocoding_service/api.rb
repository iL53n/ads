module GeocodingService
  module Api
    def geocode(city)
      response = connection.get('geocoder/v1', { city: city })

      JSON.parse(response.body) if response.success?
    end
  end
end
