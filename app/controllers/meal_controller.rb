require "pry"

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
    day = user.days.find_by(date: params[:day][:date], meal_time: params[:day][:meal_time]) || user.days.create(params[:day])
    meal = user.meals.where('lower(name)=?', params[:meal][:name].downcase).first
    meal ||= user.meals.create(params[:meal])
    day.meals << meal
    redirect to "/meals/show/#{user.slug}"
  end

  get "/meals/show/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    erb :"/meals/show"
  end

  get "/meals/:meal_slug/:slug/edit" do
    redirect_if_not_logged_in
    @meal = Meal.find_by_meal_slug(params[:meal_slug])
    user = @meal.user
    redirect_if_incorrect_user(user)

    erb :"/meals/edit"
  end

end
