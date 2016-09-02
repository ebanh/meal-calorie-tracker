require "pry"

class MealController < ApplicationController

  get "/tracker/:slug" do
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
    erb :"/meals/new"
  end

  post "/meals/:id" do
    user = User.find(params[:id])
    day = user.days.find_by(date: params[:day][:date], meal_time: params[:day][:meal_time]) || user.days.create(params[:day])
    if !params[:meal][:name].empty?
      meal = user.meals.where('lower(name)=?', params[:meal][:name].downcase).first
      meal ||= user.meals.create(params[:meal])
      day.meals << meal
    end
    day.meal_ids << params[:day][:meal_ids]
    redirect to "/meals/show/#{user.slug}"
  end

  get "/meals/show/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    erb :"/meals/show"
  end

  get "/meals/:meal_slug/edit/:slug" do
    redirect_if_not_logged_in
    @meal = Meal.find_by_meal_slug(params[:meal_slug])
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    erb :"/meals/edit"
  end

  patch "/meals/:id/edit" do
    meal = Meal.find(params[:id])
    meal.update(params[:meal])
    redirect to "/meals/show/#{meal.user.slug}"
  end

  delete "/meals/:id/delete" do
    meal = Meal.find(params[:id])
    user = current_user
    meal.delete
    remove_days_without_meals
    redirect to "/meals/show/#{user.slug}"
  end
end
