class UserController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  def show
    @user = current_user
    @events = []

    Event.where(admin_id: current_user.id).find_each do |my_event|
      @events << my_event
    end

  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)

    redirect_to user_path

  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :description)
  end


end
