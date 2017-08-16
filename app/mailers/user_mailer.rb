class UserMailer < ApplicationMailer
    default from: 'stockpricetracker@gmail.com'
 
    def notification_email(user)
        @user = user 
        @url  = 'https://stock-tracker-pparthasarathy.c9users.io/users/sign_in'
        mail(to: @user.email, subject: 'StockTracker Notification')
    end
end
