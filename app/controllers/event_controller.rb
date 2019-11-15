class EventController < ApplicationController

  before_action :set_user
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
    @participation = Participation.new
  end

  def create
    @event = Event.new(start_date: event_params[:start_date], duration: event_params[:duration], title: event_params[:title], description: event_params[:description], price: event_params[:price], location: event_params[:location], admin: current_user)


      if @event.save
        redirect_to root_path, notice: 'Evénement créé'
      else
        flash.now[:danger] = 'erreur dans la création du compte'
        render 'new'
      end

  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def set_user
    @user = current_user
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.permit(:start_date, :duration, :title, :description, :price, :location)
  end

end
