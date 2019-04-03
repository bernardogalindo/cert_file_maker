ENV['RAILS_ENV'] = 'test'

require 'pty'
require "rails_app/config/environment"
require 'minitest/autorun'
require './lib/cert_file_maker'
