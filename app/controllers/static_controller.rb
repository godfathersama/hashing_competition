class StaticController < ApplicationController
  def index
  end

  def updates
  end

  def winner
    @user = User.where('username != "mamacias"').order('score DESC')
  end
end
