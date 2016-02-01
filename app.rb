require 'sinatra'
require 'haml'
require 'active_record'
require 'sinatra/activerecord'
require './models/models.rb'
require './handlers/http_authentication.rb'

class HTTPApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  use Handlers::HttpAuthentication

  get '/' do
    haml :index
  end

  post '/squirrels' do
    name = params[:name]
    squirrel = Squirrel.new(:name => name)
    squirrel.save!
    haml :squirrels
  end

  get '/squirrels' do
    if params['name'] == 'Leo'
      haml :leo
    else
      haml :squirrels
    end
  end

end

