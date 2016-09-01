require './config/environment'
require 'rack-flash'
require 'pry'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "pizzaisgoodforyou"
  end

  get '/' do
    if logged_in?
      redirect to "/#{current_user.slug}"
    else
      erb :"/index"
    end
  end

  helpers do

    def logged_in?
     !!session[:user_id]
    end

    def current_user
     User.find(session[:user_id])
    end

    def redirect_if_not_logged_in
     if !logged_in?
       flash[:message] = "You need to be logged in to do that."
       redirect to "/login"
     end
    end

    def redirect_if_incorrect_user(user)
     if user != current_user
       flash[:message] = "You are not allowed to access another user's account."
       redirect to "/#{current_user.slug}"
     end
    end

    def all_dates_one_day(user, date)
      user.days.find_all { |day| day.date.strftime("%m%d%y") == date.strftime("%m%d%y") }
    end

    def total_calories(user, date)
     total_calories = 0
     all_dates_one_day(user, date).each { |day| total_calories += day.calories }
     total_calories
    end

    def total_calories_last_7_days(user)
      week_data = user.days.where(["date >= ?", 7.days.ago])
      week_calories = 0
      week_data.each { |day| week_calories += day.calories}
      week_calories
    end
  end
end
