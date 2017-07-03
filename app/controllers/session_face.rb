#let Bundler handle all requires
require 'bundler'
Bundler.require(:default)

# register your app at facebook to get those infos
# your app id
APP_ID     = 239153106570130
# your app secret
APP_SECRET = '39d6b381c413623b9f938e1d9af7f1d7'

Socialscopeme::App.controllers :session do

  use Rack::Session::Cookie, secret: 'PUT_A_GOOD_SECRET_IN_HERE'

  get '/' do
    if session['access_token']
      'You are logged in! <a href="/logout">Logout</a>'
    else
      '<a href="/login">Login</a>'
    end
  end

  get :loginface, :map => '/login-face' do
    # generate a new oauth object with your app data and your callback url
    session['oauth'] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, "#{request.base_url}")
    # redirect to facebook to get your code
    redirect session['oauth'].url_for_oauth_code()
  end

  get '/logout-face' do
    session['oauth'] = nil
    session['access_token'] = nil
    redirect '/'
  end

  #method to handle the redirect from facebook back to you
  get '/callback' do
    #get the access token from facebook with your code
    session['access_token'] = session['oauth'].get_access_token(params[:code])
    redirect '/'
  end


end
