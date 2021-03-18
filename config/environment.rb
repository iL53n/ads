require 'bundler/setup'
Bundler.require

require_all 'app/controllers/application_controller.rb' # we must be the first to load the parent class
require_all 'app'
