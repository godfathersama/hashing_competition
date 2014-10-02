class Notifier < ActionMailer::Base
  default from: "noreply@localhost"

  def send_registration_email(user)
    @user = user

    mail( to: @user.email,
      subject: 'Thanks for signing up!' )
  end
end
