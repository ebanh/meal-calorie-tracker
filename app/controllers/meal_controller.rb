class MealController < ApplicationController

  get "/meals/:slug" do
    redirect_if_not_logged_in


    erb :"/meals/index"
  end


end
