Socialscopeme::App.controllers :usuario do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :'cadastro', :map => 'cadastro/' do
    render 'cadastro/cadastrar'
  end

  get :new, map: '/entrar' do
    if current_account
      redirect(url('/'))
    else
      @usuario = Usuario.new
      # ap session[:gclid]
      # session['oauth'] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, "#{request.base_url}/callback")
      render 'cadastro/entrar'
    end
  end
end
