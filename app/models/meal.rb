class Meal < ActiveRecord::Base

  belongs_to :user
  has_many :meal_days
  has_many :days, through: :meal_days

  validates_presence_of :name
  validates_presence_of :calories
end
