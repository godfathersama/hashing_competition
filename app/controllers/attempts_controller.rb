class AttemptsController < ApplicationController
  layout false

  def index
    key = params[:key]
    attempt = params[:attempt]
    @user = User.where(:key => key).first
    @attempt = Attempt.new

    if @user
      score = self.score_attempt(attempt)
      @attempt.attempt = attempt
      @attempt.score = score
      @attempt.user = @user

      if !@attempt.save
        @error = 'ERROR: CANNOT SAVE ATTEMPT'
      end

      if @user.score.nil? || score > @user.score
        @user.score = score
        
        @error = 'ERROR: UNABLE TO UPDATE USER' if !@user.save
      end
      @score = score
    else
      @error = 'ERROR: NO SUCH USER'
    end
  end

  def new
    @attempt = Attempt.new
  end

  def create
    @attempt = Attempt.new(attempt_params)

    @attempt.save
  end

  def score_attempt(attempt)
    digest = Digest::SHA256.hexdigest(attempt)
    count_leading_zeros(digest)
  end

  def count_leading_zeros(digest)
    zeros = 0

    digest.each_char do |c|
      break if c != '0'
      zeros += 1
    end

    zeros
  end

  private
  def attempt_params
    params.require(:user).permit(:attempt, :user_id)
  end
end
