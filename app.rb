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
    haml :root
  end

  # FIXME: I'm not RESTful!
  get '/squirrels' do
    if params['name'] == 'Leo'
      erb :leo
    elsif params['name'] == 'DDM'
      erb :ddm
    else
      erb :squirrels
    end
  end

  post '/squirrels' do
    name = params[:name]
    desc = params[:description]
    squirrel = Squirrel.new(:name => name, :description => desc)
    squirrel.save!
    erb :squirrels
  end
end

