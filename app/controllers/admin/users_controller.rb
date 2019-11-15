class Admin::UsersController < ApplicationController

  before_action :is_admin?

  def index
    @users = User.all
    @user = current_user
  end

  # def show
  #   @user = current_user
  #   @events = []
  # 
  #   Event.where(admin_id: current_user.id).find_each do |my_event|
  #     @events << my_event
  #   end
  #
  # end
  #
  # def edit
  #   @user = current_user
  # end
  #
  # def update
  #   @user = current_user
  #   @user.update(user_params)
  #
  #   redirect_to user_path
  #
  # end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :description)
  end

  def is_admin?
    #A moins que le user ne soit un admin, on le redirige vers l'accueil
    unless current_user.is_admin == true
      redirect_to root_path
    end

  end

end
