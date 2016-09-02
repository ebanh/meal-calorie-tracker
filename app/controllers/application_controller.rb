require './config/environment'
require 'rack-flash'

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

    def total_calories(user, date)
     total_calories = 0
     all_dates = user.days.find_all { |day| day.date.strftime("%m%d%y") == date.strftime("%m%d%y") }
     meals_in_a_day = all_dates.map { |day| day.meals }.flatten
     meals_in_a_day.each { |meal| total_calories += meal.calories }
     total_calories
    end

    def total_calories_last_7_days(user)
      week_calories = 0
      week_data = user.days.where(["date >= ?", 7.days.ago])
      week_meals = week_data.map { |day| day.meals }.flatten
      week_meals.each { |meal| week_calories += meal.calories}
      week_calories
    end

    def remove_days_without_meals
      Day.all.each do |day|
        if day.meal_ids.empty?
          day.delete
        end
      end
    end

    def remove_meals_without_days
      Meal.all.each do |meal|
        if meal.day_ids.empty?
          meal.delete
        end
      end
    end

  end

end
