require 'sinatra'
require 'haml'
require 'active_record'
require 'sinatra/activerecord'
require './models/models.rb'

class HTTPApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do
    haml :index
  end
end
