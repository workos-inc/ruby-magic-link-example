# frozen_string_literal: true

require 'dotenv/load'
require 'sinatra'
require 'workos'
require 'json'

WorkOS.key = ENV['WORKOS_API_KEY']
# Get your project_id and configure your domain and
# redirect_uris at https://dashboard.workos.com/sso/configuration
PROJECT_ID = 'project_01EGKAEB7G5N88E83MF99J785F'
REDIRECT_URI = 'http://localhost:4567/callback'

use(
  Rack::Session::Cookie,
  key: 'rack.session',
  domain: 'localhost',
  path: '/',
  expire_after: 2_592_000,
  secret: SecureRandom.hex(16)
)

get '/' do
  @current_user = session[:user] && JSON.pretty_generate(session[:user])

  erb :index, :layout => :layout
end

post '/passwordless-auth' do
  session = WorkOS::Passwordless.create_session(
    email: params[:email],
    type: 'MagicLink',
    redirect_uri: REDIRECT_URI
  )
  WorkOS::Passwordless.send_session(session.id)

  redirect '/check-email'
end

get '/check-email' do
  erb :check_email, :layout => :layout
end

get '/callback' do
  profile = WorkOS::SSO.profile(
    code: params['code'],
    project_id: PROJECT_ID,
  )

  session[:user] = profile.to_json

  redirect '/'
end

get '/logout' do
  session[:user] = nil

  redirect '/'
end
