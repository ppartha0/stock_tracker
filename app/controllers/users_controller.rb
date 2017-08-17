class UsersController < ApplicationController
    def notify
        @user = current_user
        UserMailer.notification_email(@user).deliver
        render ("users/notify.html.erb")
    end
    
    # def notify
    #     RestClient.post "https://api:key-cf8506cf27334e76d6188d3dcd52064a"
    #     "@api.mailgun.net/v3/sandboxab68412aee7e40d88ad93dc17abc623e.mailgun.org/messages",
    #     :from => "Mailgun Sandbox <postmaster@sandboxab68412aee7e40d88ad93dc17abc623e.mailgun.org>",
    #     :to => "Pooja <pparthasarathy@chicagobooth.edu>",
    #     :subject => "Hello Pooja",
    #     :text => "Congratulations Pooja, you just sent an email with Mailgun!  You are truly awesome!"
    # end
end
