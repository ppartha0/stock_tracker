class TrackingsController < ApplicationController
  def index
    @trackings = Tracking.all

    render("trackings/index.html.erb")
  end

  def show
    @tracking = Tracking.find(params[:id])

    render("trackings/show.html.erb")
  end

  def new
    @tracking = Tracking.new

    render("trackings/new.html.erb")
  end

  def create
    @tracking = Tracking.new

    @tracking.stock_id = params[:stock_id]
    @tracking.user_id = params[:user_id]

    save_status = @tracking.save

    if save_status == true
      redirect_to("/trackings/#{@tracking.id}", :notice => "Tracking created successfully.")
    else
      render("trackings/new.html.erb")
    end
  end

  def edit
    @tracking = Tracking.find(params[:id])

    render("trackings/edit.html.erb")
  end

  def update
    @tracking = Tracking.find(params[:id])

    @tracking.stock_id = params[:stock_id]
    @tracking.user_id = params[:user_id]

    save_status = @tracking.save

    if save_status == true
      redirect_to("/trackings/#{@tracking.id}", :notice => "Tracking updated successfully.")
    else
      render("trackings/edit.html.erb")
    end
  end

  def destroy
    @tracking = Tracking.find(params[:id])

    @tracking.destroy

    if URI(request.referer).path == "/trackings/#{@tracking.id}"
      redirect_to("/", :notice => "Tracking deleted.")
    else
      redirect_to(:back, :notice => "Tracking deleted.")
    end
  end
end
