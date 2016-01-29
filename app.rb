require 'sinatra'
require 'haml'

class HTTPApp < Sinatra::Base
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
    # def protected!
    #   return if authorized?
    #   headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    #   halt 401, "Not authorized\n"
    # end
    #
    # def authorized?
    #   @auth ||= Rack::Auth::Basic::Request.new(request.env)
    #   @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
    # end
  end

  before do
    @user = User.get(session[:user_id])
  end

  get '/' do
    "Hello anonymous"
  end

  get '/protected', auth: :user do
    "Hello, #{user.name}."
  end

  post '/login' do
    session[:user_id] = User.authenticate(params).id
  end

  get '/logout' do
    session[:user_id] = nil
  end
end
