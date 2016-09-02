class DayController < ApplicationController

  get "/days/list/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    redirect_if_incorrect_user(@user)
    erb :"/days/list"
  end

end
