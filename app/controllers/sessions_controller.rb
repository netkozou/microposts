class SessionsController < ApplicationController
  # before_action :set_user, only: [:edit, :update, :destroy]
  def new
  end
  
  def edit
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      flash[:danger] = "invalid email/password combination"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
  end
  
end
