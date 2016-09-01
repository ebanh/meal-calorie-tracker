class MealController < ApplicationController

  get "/meals/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    @date = Time.now
    redirect_if_incorrect_user(@user)
    @total_calories_today = total_calories(@user, Time.now)
    @total_week_calories = total_calories_last_7_days(@user)
    erb :"/meals/index"
  end

  get "/meals/new/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    erb :"meals/new"  
  end

end
