Socialscopeme::App.controllers :session do

  get :login, :map => '/login' do
    # puts current_account
    if current_account
      redirect(url(:base, :index))
    else
      render 'cadastro/login'
    end
  end

  post :create do

    if account = Account.authenticate(params[:user], params[:pass])
      set_current_account(account)
      # ap account
      # ap current_account
      redirect url(back)
    else
      params[:user], params[:pass] = h(params[:user]), h(params[:pass])
      flash[:error] = "Problema ao efetuar login."
      params[:previousurl] = h(params[:previousurl])
    end

  end

  get :destroy, map: '/logout' do
    set_current_account(nil)
    redirect url(:base, :index)
  end

end
