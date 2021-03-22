ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

require_all 'app/controllers/concerns'
require_all 'app/controllers/application_controller.rb' # we must be the first to load the parent class
require_all 'app'
