require 'open-uri'

class PortfoliosController < ApplicationController
  def index
    userid = current_user.id
    @portfolios = User.find(userid).portfolios
    newsapiurl = "https://newsapi.org/v1/articles?source=bloomberg&sortBy=top&apiKey=858fb9f6a6304e6dbc669302aa6554ef"
    raw_data = open(newsapiurl).read
    @parsed_data = JSON.parse(raw_data)
    
    render("portfolios/index.html.erb")
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    
    render("portfolios/show.html.erb")
  end

  def new
    @portfolio = Portfolio.new

    render("portfolios/new.html.erb")
  end

  def create
    @portfolio = Portfolio.new
    @portfolio.user_id = params[:user_id]
    @portfolio.portname = params[:portname]

    save_status = @portfolio.save
    if save_status == true
      redirect_to("/portfolios/#{@portfolio.id}", :notice => "Portfolio created successfully.")
    else
      render("portfolios/new.html.erb")
    end
  end

  def edit
    @portfolio = Portfolio.find(params[:id])

    render("portfolios/edit.html.erb")
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    @portfolio.user_id = params[:user_id]
    @portfolio.portname = params[:portname]
    
    save_status = @portfolio.save

    if save_status == true
        redirect_to("/portfolios/#{@portfolio.id}", :notice => "Portfolio updated successfully.")
    else
        render("portfolios/edit.html.erb")
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])

    @portfolio.destroy

    if URI(request.referer).path == "/portfolios/#{@portfolio.id}"
      redirect_to("/", :notice => "Portfolio deleted.")
    else
      redirect_to(:back, :notice => "Portfolio deleted.")
    end
  end
end
