class User < ActiveRecord::Base
  include Slug
  extend ClassSlug

  has_many :meals
  has_many :days

  has_secure_password
  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password

end
