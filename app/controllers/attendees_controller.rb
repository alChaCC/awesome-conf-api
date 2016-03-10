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

  def interleave_by_interests
    if params[:interest]
      @related_attendees, @not_related_attendees = Attendee.paginate(:page => params[:page], :per_page => 25).find_related_people(params[:interest])
      render 'attendees/interleave_by_interests', status: :ok
    else
      render json: { status: "interest not given" }, status: :bad_request
    end
  end

end
