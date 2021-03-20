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
    # not sure about send the user, maybe I didn't right understand the task
    result = CreateAdService.call(ad: params, user: User.find(1))

    if result.success?
      serializer = AdSerializer.new(result.ad)

      body serializer.serialized_json
      status 201
    else
      errors = ErrorSerializer.error_response(result.ad)

      body errors
      status 422
    end
  end
end
