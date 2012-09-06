class SessionsController < ApplicationController
  def new

  end
  def create
    # Para que sessions implemente una interfaz REST, una autenticación
    #valida crea una nueva sesión
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
      # Crear sesión y reditigir a la página de despliegue de usuario
    else
      # Crear un mensaje de error y redirigir a la página de signin
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    end
  end
  def destroy

  end
end
