class MealController < ApplicationController

  get "/meals/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    @date = Time.now
    redirect_if_incorrect_user(@user)
    @total_calories = total_calories_one_day(@user, Time.now)
    erb :"/meals/index"
  end


end
