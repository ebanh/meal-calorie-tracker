class UserController < ApplicationController

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect to "/#{current_user.slug}"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/#{user.slug}"
    else
      redirect to "/login"
    end
  end

  get '/signup' do
    if logged_in?
      redirect to "/#{current_user.slug}"
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    user = User.create(params)
    session[:user_id] = user.id
    if user.save
      redirect to "/#{user.slug}"
    else
      redirect to "/signup"
    end
  end

  get '/logoff' do
    session.clear
    redirect to "/login"
  end

end
