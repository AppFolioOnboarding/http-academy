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

  #############################################################################
  # FIXME: I'm not RESTful!
  # Idea: In RESTful architecture, we treat everything like a resource. For
  # example, to visit the page for a specific squirrel, you might navigate to:
  #
  # localhost:9292/squirrels/3
  #
  # But there are other, less efficient ways to navigate to the page for a
  # specific squirrel. This "squirrels" route is a great example of how to
  # violate resource-oriented architecture. How can we fix this?
  #
  get '/squirrels' do
    # THIS CODE IS BAD, AND IT SHOULD FEEL BAD. CHANGE IT.
    if params['name'] == 'Leo'
      erb :leo
    elsif params['name'] == 'DDM'
      erb :ddm
    else
      erb :squirrels
    end
  end

  get '/squirrel' do
    # CODE GOES HERE
  end

  #############################################################################

  post '/squirrels' do
    name = params[:name]
    desc = params[:description]
    squirrel = Squirrel.new(:name => name, :description => desc)
    squirrel.save!
    erb :squirrels
  end
end

