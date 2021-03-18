class AdsController < ApplicationController
  before do
    content_type :json
  end

  get "/" do
    ads = Ad.order(updated_at: :desc)
    serializer = AdSerializer.new(ads)

    body serializer.serialized_json
    status 200
  end

  post "/ads" do
    # Todo: add user_id in params
    # from HW: 'Вместо токена пользователя при создании объявления передавайте явный `user_id` гипотетического пользователя.'
    # Todo: add strong params [:title, :description, :city]
    ad = Ad.new(params)

    if ad.save
      serializer = AdSerializer.new(ad)

      body serializer.serialized_json
      status 201
    else
      body "You can't save new ad"
      halt 422
    end
  end
end
