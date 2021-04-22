FactoryBot.define do
  factory :ad do
    title { 'Ad title' }
    description { 'Ad description' }
    city { 'City' }
    lat { 11 }
    lon { 22 }
    user_id { 101 }
  end
end
