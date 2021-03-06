class UsersController < ApplicationController
  def index
    @users = User.all.order('score DESC, updated_at ASC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :success
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :username)
  end 
end
