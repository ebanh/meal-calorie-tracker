class Meal < ActiveRecord::Base

  belongs_to :user
  has_many :meal_days
  has_many :days, through: :meal_days

end
