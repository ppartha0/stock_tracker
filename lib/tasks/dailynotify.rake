namespace :dailynotify do
    task run: :environment do
        require 'open-uri'
        #### put all the logic you want to run on a daily basis here
        
        #### Step 1: Loop through list of users 
        User.all.each do |user|
            #### Step 2: Loop through list of stock records by user
            user.stocks.each do |stock|
                #### Step 3: For each stock record, run an API query to get the High and Low Price.
                userticker = stock.ticker
                userprice = stock.price.to_f
                ## Retrieve H/L for the stock from AlphaVantage API
                querydatetime = Date.today.prev_weekday.strftime("%Y-%m-%d")
                apiurl = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=" + userticker + "&apikey=BFE2BUG6S4TCSZIS"
                raw_data = open(apiurl).read
                parsed_data = JSON.parse(raw_data)
                userhigh = parsed_data["Time Series (Daily)"][querydatetime]["2. high"].to_f
                userlow = parsed_data["Time Series (Daily)"][querydatetime]["3. low"].to_f
                #### Step 4: If tracking price lies within the band, send the user an email by calling UserMailer
                if userprice > userlow && userprice < userhigh
                    # puts "#{user.username.capitalize}, #{stock.ticker} in your #{Portfolio.find(stock.portfolio_id).portname} portfolio hit its target price of #{stock.price} today. Time to get to work!"
                    ticker = stock.ticker
                    portname = Portfolio.find(stock.portfolio_id).portname
                    price = stock.price
                    #puts user.username, ticker
                    UserMailer.notification_email(user, ticker, portname, price).deliver
                    
                end
            end
        end
    end
end
