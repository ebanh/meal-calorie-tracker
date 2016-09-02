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

  patch "/days/:id/edit" do
    day = Day.find(params[:id])
    day.update(params[:day])
    redirect to "/days/show/#{day.user.slug}"
  end

  delete "/days/:id/delete" do
    day = Day.find(params[:id])
    user = current_user
    day.delete
    remove_meals_without_days
    redirect to "/days/show/#{user.slug}"
  end

end
