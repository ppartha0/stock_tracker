namespace :helloworld do
    task run: :environment do
        puts "hello"
        #### put all the logic you want to run on a daily basis here
        # @user = current_user
        # UserMailer.notification_email(@user).deliver
    end
end
