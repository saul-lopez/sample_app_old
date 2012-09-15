class MicropostsController < ApplicationController
  before_filter :signed_in_user

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success]  = "Micropost created!"
      redirect_to root_url
    else
      # static_pages/home espera una lista de microposts
      # así que Si se falla al guardar un micropost, enviar una lista vacía
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
  end
end