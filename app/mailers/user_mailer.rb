class UserMailer < ApplicationMailer
  default from: 'noreply@example.com'

  def welcome(user)
    @user = user
    @company = user.company

    mail(
      to: @user.email,
      subject: "Welcome to #{@company.name}!"
    )
  end
end
