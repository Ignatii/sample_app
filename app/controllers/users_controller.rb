class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    #@user = User.new(params[:user]).permit(:name, :email, :password, :password_confirmation)
    @user = User.new(user_params)
    flash[:success] = "Welcome to the Sample App Created by Ignatiy!Dobro pozalovat gosti dorogie :)"
    if @user.save
      redirect_to @user
      #redirect_to user_url(@user)
    else
      render 'new'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
end
