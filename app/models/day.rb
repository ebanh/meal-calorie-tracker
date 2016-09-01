class Day < ActiveRecord::Base
  include Slug
  extend ClassSlug

  belongs_to :user
  has_many :meal_days
  has_many :meals, through: :meal_days

  validates_presence_of :date
  validates_presence_of :meal_time
end
