class HashesController < ApplicationController
  layout false

  def attempt
    key = params[:key]
    attempt = params[:attempt]

    @user = User.where(:key => key).first

    if @user.nil?
      @error = 'ERROR: NO SUCH USER'
    else
      new_score = self.score_attempt(attempt)

      if @user.score.nil?
        @user.score = new_score
        @score = new_score

        if !@user.save
          @error = 'ERROR SAVING NEW SCORE: TRY AGAIN!'
        end
      elsif @user.score < new_score
        @user.score = new_score
        @score = new_score

        if !@user.save
          @error = 'ERROR SAVING NEW SCORE: TRY AGAIN!'
        end
      else
        @score = @user.score
      end
    end
      puts @score
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
end
