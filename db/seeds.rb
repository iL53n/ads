require_relative '../app/models/user'
require_relative '../app/models/ad'

# Create users
users = User.create!([
  {
   name: 'Bob',
   email: 'bob@example.com',
   password: 'givemeatoken'
  }
])

# Create ads
Ad.create!([
  {
   title: 'Ad title 1',
   description: 'Ad description 1',
   city: 'City 1',
   user: users[0]
  },
  {
   title: 'Ad title 2',
   description: 'Ad description 2',
   city: 'City 1',
   user: users[0]
  },
  {
   title: 'Ad title 3',
   description: 'Ad description 3',
   city: 'City 2',
   user: users[0]
  }
])
