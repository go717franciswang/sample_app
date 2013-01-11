class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash.now[:success] = "Welcome to the Sample App!"
      render 'show'
    else
      render 'new'  
    end
  end

  def show
    @user = User.find params[:id]
  end
end
