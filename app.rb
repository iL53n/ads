require 'sinatra'
require 'sinatra/activerecord'
require 'fast_jsonapi'
require 'pg'
require 'rack'
require 'json'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }
Dir["#{current_dir}/serializers/*.rb"].each { |file| require file }

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
  ad = Ad.new(params)

  if ad.save
    serializer = AdSerializer.new(ad)

    body serializer.serialized_json
    status 201
  else
    halt 422, "You can't save new ad"
  end
end
