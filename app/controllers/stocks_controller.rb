class StocksController < ApplicationController
  def index
    userid = current_user.id
    @stocks = User.find(userid).stocks

    render("stocks/index.html.erb")
  end

  def show
    @stock = Stock.find(params[:id])
    ticker = @stock.ticker
    ## Retrieve last close price for the stock from AlphaVantage API
    querydatetime = Date.today.prev_weekday.strftime("%Y-%m-%d")
    apiurl = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=" + ticker + "&apikey=BFE2BUG6S4TCSZIS"
    raw_data = open(apiurl).read
    parsed_data = JSON.parse(raw_data)
    @lastclose = parsed_data["Time Series (Daily)"][querydatetime]["4. close"]
    ## historical_data = parsed_data["Time Series (Daily)"].map{|x| x[1]["4. close"]}
    
    ## Retrieve 60-day SMA 
    smaurl = "https://www.alphavantage.co/query?function=SMA&symbol=" + ticker + "&interval=daily&time_period=60&series_type=close&apikey=BFE2BUG6S4TCSZIS"
    raw_sma = open(smaurl).read
    parsed_sma = JSON.parse(raw_sma)
    @lastSMA = parsed_sma["Technical Analysis: SMA"][querydatetime]["SMA"]
    
    ## Retrieve 60-day EWMA
    ewmaurl = "https://www.alphavantage.co/query?function=EMA&symbol="+ ticker + "&interval=daily&time_period=60&series_type=close&apikey=BFE2BUG6S4TCSZIS"
    raw_ewma = open(ewmaurl).read
    parsed_ewma = JSON.parse(raw_ewma)
    @lastEWMA = parsed_ewma["Technical Analysis: EMA"][querydatetime]["EMA"]
    
    ### Add price charts if you can
    ### http://www.fusioncharts.com/ruby-on-rails-charts/
    
    render("stocks/show.html.erb")
  end

  def new
    @stock = Stock.new

    render("stocks/new.html.erb")
  end

  def create
    @stock = Stock.new
    ticker = params[:stock_id]
    price = params[:price]

    ### Test to see if a valid ticker has been provided
    ## Retrieve last close price for the stock from AlphaVantage API
    querydatetime = Date.today.prev_weekday.strftime("%Y-%m-%d")
    apiurl = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=" + ticker + "&apikey=BFE2BUG6S4TCSZIS"
    raw_data = open(apiurl).read
    parsed_data = JSON.parse(raw_data)
    if parsed_data.keys[0] == "Error Message"  
      @errormsg = "This isn't a valid ticker! Make sure to use a listed stock symbol."
      render("stocks/new.html.erb")
    elsif price == ""
      @errormsg = "You need to add a tracking price! Stock not added to portfolio."
      render("stocks/new.html.erb")
    else
      
      @stock.ticker = params[:stock_id]
      @stock.price = params[:price]
      @stock.portfolio_id = params[:portfolio_id]

      save_status = @stock.save

      if save_status == true
        redirect_to("/stocks/#{@stock.id}", :notice => "Stock created successfully.")
      else
        render("stocks/new.html.erb")
      end
    end  
  end

  def edit
    @stock = Stock.find(params[:id])

    render("stocks/edit.html.erb")
  end

  def update
    @stock = Stock.find(params[:id])
    ticker = params[:ticker]
    price = params[:price]

    ### Test to see if a valid ticker has been provided
    ## Retrieve last close price for the stock from AlphaVantage API
    querydatetime = Date.today.prev_weekday.strftime("%Y-%m-%d")
    apiurl = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=" + ticker + "&apikey=BFE2BUG6S4TCSZIS"
    raw_data = open(apiurl).read
    parsed_data = JSON.parse(raw_data)
    if parsed_data.keys[0] == "Error Message"  
      @errormsg = "This isn't a valid ticker! Make sure to use a listed stock symbol."
      render("stocks/edit.html.erb")
    elsif price == ""
      @errormsg = "You need to add a tracking price! Stock not updated."
      render("stocks/edit.html.erb")
    else
      @stock.ticker = params[:ticker]
      @stock.price = params[:price]
      @stock.portfolio_id = params[:portfolio_id]

      save_status = @stock.save

      if save_status == true
        redirect_to("/stocks/#{@stock.id}", :notice => "Stock updated successfully.")
      else
        render("stocks/edit.html.erb")
      end
    end  
  end

  def destroy
    @stock = Stock.find(params[:id])

    @stock.destroy

    if URI(request.referer).path == "/stocks/#{@stock.id}"
      redirect_to("/", :notice => "Stock deleted.")
    else
      redirect_to(:back, :notice => "Stock deleted.")
    end
  end
end
