class User < ActiveRecord::Base
  before_create :assign_unique_key

  validates_presence_of :username, on: :create
  validates_presence_of :email, on: :create

  has_many :attempts

  def assign_unique_key
    self.key = SecureRandom.hex
  end

  def unique_key?(key)
    self.class.count(:conditions => {:key => key}) == 0
  end

  def email_key
    Notifier.send_registration_email(self).deliver
  end
end
