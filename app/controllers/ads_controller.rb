class AdsController < ApplicationController
  include PaginationLinks

  before do
    content_type :json
  end

  get "/" do
    ads = Ad.order(updated_at: :desc).page(params[:page])
    serializer = AdSerializer.new(ads, links: pagination_links(ads))

    body serializer.serialized_json
    status 200
  end

  post "/ads" do
    result = CreateAdService.call(
      ad: params,
      user_id: 99
    )

    if result.success?
      serializer = AdSerializer.new(result.ad)

      body serializer.serialized_json
      status 201
    else
      # Todo: improve, add ApiErrors module
      errors = ErrorSerializer.error_response(result.ad)
                              .to_json
      body errors
      status 422
    end
  end
end
