namespace :test1 do
    task run: :environment do
        
        user = User.find(1)
        UserMailer.new_record_notification(user)
         
    end
end
