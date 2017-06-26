Socialscopeme::App.controllers :usuario do
  
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
      render 'cadastro/cadastrar'
    end
  end

  post :create do

    @usuario = Usuario.new(params)

    @usuario.password = params['password']
    @usuario.password_confirmation = params['password_confirmation']

    @usuario.role = 'usuario'
    if @usuario.save
      set_current_account(@usuario)
      flash[:success] = redirect(url(:base,:index))
    else
      ap 'deu ruim'
      flash.now[:error] = pat(:create_error, model: 'usuario')
      render 'cadastro/cadastrar'
    end
  end
end
