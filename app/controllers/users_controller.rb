class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :signed_in_user_donts, only: [:new, :create]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  def index
    @users = User.paginate(page: params[:page])
  end
  def new
    @user = User.new()
  end
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Wellcome to the sample app, #{@user.name}!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end
  def edit
    # El usuario actual se obtiene en el filtro correct_user
  end
  def update
    # El usuario actual se obtiene en el filtro correct_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
      #Handle a successfull update.
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
    def signed_in_user_donts
      redirect_to root_path unless !signed_in?
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path, notice: "Intento editar un usuario distinto. No mameye." unless current_user?(@user)
    end
    def admin_user
      @user = User.find(params[:id])
      redirect_to root_path unless (current_user.admin? && current_user != @user)
    end
end
