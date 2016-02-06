ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require File.expand_path '../../app.rb', __FILE__
require_relative '../models/models.rb'
