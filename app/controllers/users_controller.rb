class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  def new
    @user = User.new()
  end
  def show
    @user = User.find(params[:id])
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
  private
    def signed_in_user
      redirect_to signin_url, notice: "Please sign in" unless signed_in?
      # El anterior redirect es equivalente a:
      # flash[:notice] = "Please sign in."
      # redirect_to signin_url
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path, notice: "Intento editar un usuario distinto. No mameye." unless current_user?(@user)
    end
end
