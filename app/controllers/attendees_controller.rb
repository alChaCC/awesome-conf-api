class AttendeesController < ApplicationController
  def index
    @attendees = Attendee.paginate(:page => params[:page], :per_page => 25)
    render 'attendees/index', status: :ok
  end

  def show
    @attendee = Attendee.find_by_id(params[:id])
    if @attendee
      render 'attendees/show', status: :ok
    else
      render json: { status: "Attendee not found" }, status: :not_found
    end
  end
end
