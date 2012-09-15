class StaticPagesController < ApplicationController
  def home
    if signed_in?
      # Instancia de micropost a usarse en el formulario
      @micropost = current_user.microposts.build if signed_in?
      # Lista de microposts previos
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about

  end

  def contact

  end
end
