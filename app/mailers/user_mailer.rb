class UserMailer < ApplicationMailer
    #require 'mailgun'
    default from: 'stockpricetracker@gmail.com'
    #default from: 'mailgun@sandboxab68412aee7e40d88ad93dc17abc623e.mailgun.org'
 
    def notification_email(user, ticker, portname, price)
        @user = user 
        @ticker = ticker
        @portname = portname
        @price = price
        sub = 'StockPriceTracker Notification for ' + @ticker
        mail(to: @user.email, subject: sub)
    end
    
end
