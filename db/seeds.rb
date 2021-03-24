require_relative '../app/models/ad'

# Create ads
Ad.create!([
  {
   title: 'Ad title 1',
   description: 'Ad description 1',
   city: 'City 1',
   user_id: 1
  },
  {
   title: 'Ad title 2',
   description: 'Ad description 2',
   city: 'City 1',
   user_id: 2
  },
  {
   title: 'Ad title 3',
   description: 'Ad description 3',
   city: 'City 2',
   user_id: 3
  }
])
