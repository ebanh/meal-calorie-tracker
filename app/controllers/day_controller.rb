class DayController < ApplicationController

  get "/days/show/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    erb :"/days/show"
  end

  get "/days/:date_slug/edit/:slug" do
    redirect_if_not_logged_in
    @day = Day.find_by_date_slug(params[:date_slug])
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    erb :"/days/edit"
  end

end
