class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create update]
  before_action :get_user, only: %i[show update destroy]
  
  swagger_controller :users, 'Users'

  swagger_api :index do
    summary "Fetches all User items"
    notes "This lists all the active users"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end

  def index 
    @users = User.all

    render json: @users
  end   

  def show 
    render json: { user: @user }
  end 

  def create 
    @user = User.new(user_params)

    if @user.save
      render json: { status: 'Success', user: @user }
    else
      render json: { status: 'error', errors: @user.errors.full_messages }
    end 
  end 

  def update 
    if @user.update(user_update_params)
      render json: { status: 'success', user: @user }
    else
      render json: { status: 'error', errors: @user.errors.full_messages }
    end
  end 

  private 

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end 

  def user_update_params
    params.require(:user).permit(:full_name, :address, :phone, :password, :password_confirmation)
  end 

  def get_user
    @user = User.find(params[:id])

    return render json: {errors: ["User not found!"]}, status: 404 if @user.blank?
  end 
end
