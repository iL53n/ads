require 'sinatra'
require 'sinatra/activerecord'
require 'fast_jsonapi'
require 'pg'
require 'rack'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }
Dir["#{current_dir}/serializers/*.rb"].each { |file| require file }

get "/" do
  ads = Ad.order(updated_at: :desc)
  serializer = AdSerializer.new(ads)

  serializer.serialized_json
end

post "/abs" do
  @ad = Ad.create(params[:title, :description, :city])
end
