class ParticipationController < ApplicationController

  def index
  end

  def new

  end

  def create
    @event = Event.find(params[:event_id])

    if @event.participants.include? current_user
      flash[:error] = "Vous participez déjà à l'événement !"
      redirect_to @event
      return
    end

    @amount = @event.price * 100

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    p = Participation.create(participant: current_user, event: @event, stripe_customer_id: customer.id)
    flash[:success] = "Vous êtes bien inscrit à l'événement"
    redirect_to @event

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to @event

  end

  def destroy
  end

  private

  def participant_params

  end
end
