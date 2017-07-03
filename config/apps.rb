
Padrino.configure_apps do
  # enable :sessions
  set :session_secret, '1fbe4afdcf1f95f225295b9eb8add1ebe0f91d086afe19f958baa237aed7b7fd'

  set :protection, false
  set :protect_from_csrf, false

  use Rack::Session::Cookie, :key => '_rack_session',
      :path => '/',
      :expire_after => 14400, # In seconds
      :secret => settings.session_secret

  end

# Mounts the core application for this project

Padrino.mount('Socialscopeme::Admin', :app_file => Padrino.root('admin/app.rb')).to('/admin')
Padrino.mount('Socialscopeme::App', :app_file => Padrino.root('app/app.rb')).to('/')
