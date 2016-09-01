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

  post "/meals/:id" do
    user = User.find(params[:id])
    if (params[:meal][:name].empty? || params[:meal][:calories].empty?) && params[:day][:meal_ids].empty?
      flash[:message] = "Meal information incomplete."
      redirect to "/meals/new/#{user.slug}"
    end
    meal = user.meals.find_by(name: params[:meal][:name]) || user.meals.create(params[:meal])
    day = user.days.find_by(date: params[:day][:date], meal_time: params[:day][:meal_time]) || user.days.create(params[:day])
    day << meal
    redirect to "/meals/list/#{user.slug}"
  end

  get "/meals/list/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    erb :"/meals/list"
  end

end
