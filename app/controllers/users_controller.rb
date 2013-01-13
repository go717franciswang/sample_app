class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :non_signed_in_user, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

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
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updates"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private
    
    def signed_in_user
      # redirect_to signin_path, notice: "Please sign in." unless signed_in?
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def non_signed_in_user
      redirect_to root_path, notice: "You have no business here." unless !signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user.admin? && !current_user?(@user)
    end
end
