class HashesController < ApplicationController
  def attempt
    key = params[:key]
    attempt = params[:attempt]

    @user = User.where(:hash => key).first

    new_score = self.score_attempt(attempt)

    if @user.score < new_score
      @user.score = new_score
      if !@user.save
        @error = 'ERROR SAVING NEW SCORE: TRY AGAIN!'
      end
    end
  end

  private
  def score_attempt(attempt)
    digest = Digest::SHA256.hexdigest(attempt)
    cout_leading_zeros(digest)
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
