class UserMailer < ApplicationMailer
  default from: 'muskank@witmates.com'
 
  def answer_notification(user)
    #@user = params[:user]
    @user = user
    mail(to: @user.email, subject: 'You received answer on your question')
  end

end

