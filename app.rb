require 'sinatra'
require 'sinatra/activerecord'
require 'pg'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

get "/" do
  @ads = Ad.all.to_json
end

post "/abs" do
  @ad = Ad.create(params[:title, :description, :city])
end
