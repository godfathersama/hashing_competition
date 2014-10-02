class User < ActiveRecord::Base
  before_create :assign_unique_hash
  after_create :email_hash

  validates_presence_of :username, on: :create
  validates_presence_of :email, on: :create 
end
