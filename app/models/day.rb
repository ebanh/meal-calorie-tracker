class Day < ActiveRecord::Base
  has_many :user_days
  has_many :users, through: :user_days
  has_many :meals, through: :users

  validates_presence_of :date
  validates_presence_of :meal_time
end
