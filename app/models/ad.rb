class Ad < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, :city, presence: true
end
