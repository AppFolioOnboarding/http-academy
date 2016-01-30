require 'sinatra'
require 'haml'
require 'active_record'
require 'sinatra/activerecord'
require './models/models.rb'

class HTTPApp < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set sessions: true

  register do
    def auth(type)
      condition do
        redirect '/login' unless send("is_#{type}?")
      end
    end
  end

  helpers do
    def is_user?
      @user != nil
    end
  end

  before do
    @user = User.find(session[:user_id]) unless User.count == 0
  end

  get '/' do
    haml :index
  end
end
