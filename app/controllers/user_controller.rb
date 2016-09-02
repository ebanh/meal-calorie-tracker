class UserController < ApplicationController

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      redirect to "/tracker/#{current_user.slug}"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tracker/#{user.slug}"
    else
      flash[:message] = "Incorrect username/ password combination"
      redirect to "/login"
    end
  end

  get '/signup' do
    if logged_in?
      redirect to "/tracker/#{current_user.slug}"
    else
      erb :"/users/signup"
    end
  end

  post '/signup' do
    if User.find_by(username: params[:username])
      flash[:message] = "username is already in use"
      redirect "/signup"
    elsif User.find_by(email: params[:email])
      flash[:message] = "email is already in use"
      redirect "/signup"
    end
    user = User.create(params)
    session[:user_id] = user.id
    if user.save
      redirect to "/tracker/#{user.slug}"
    else
      flash[:message] = "please fill out the entire form to create your account"
      redirect to "/signup"
    end
  end

  get '/logoff' do
    session.clear
    redirect to "/"
  end

end
