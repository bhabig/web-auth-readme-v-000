class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

 def create
   resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
     req.params['client_id'] = ENV['SECRET_KEY']
     req.params['client_secret'] = ENV['PASSWORD']
     req.params['grant_type'] = 'authorization_code'
     req.params['redirect_uri'] = "http://localhost:3000/auth"
     req.params['code'] = params[:code]
   end

   body = JSON.parse(resp.body)
   session[:token] = body["access_token"]
   redirect_to root_path
   # raise response["access_token"].inspect
 end

end
