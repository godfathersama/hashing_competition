class UsersController < ApplicationController
  before_create :assign_unique_hash
  after_create :email_hash

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :username)
  end

  def assign_unique_hash
    self.hash = ActiveSupport::SecureRandom.hex(5) until unique_hash?
  end

  def unique_hash?
    self.class.count(:conditions => {:hash => hash}) == 0
  end

  def email_hash
    Notifier.send_registration_email(@user).deliver
  end
end
