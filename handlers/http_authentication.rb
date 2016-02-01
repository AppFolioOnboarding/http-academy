module Handlers
  class HttpAuthentication < Sinatra::Base
    helpers do
      def http_authentication_protected!
        return if http_authorized?
        headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
        halt 401, "Not authorized\n"
      end

      def http_authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
      end
    end

    get '/http-authentication' do
      http_authentication_protected!
      haml :http_authentication
    end
  end
end
