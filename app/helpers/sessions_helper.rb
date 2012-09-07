module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  def signed_in?
    !current_user.nil?
  end

  # si algien lo entiende, que me explique:
  #obtenido de: http://ruby.railstutorial.org/chapters/sign-in-sign-out?version=3.2#sec-current_user

  def current_user=(user)
    @current_user = user
  end

  def current_user
    # la asignación or ( ||= ) solo se realiza si @current_user no esta
    # definido. Esto es que la consulta a  la BD solo se realiza una vez.
    # es equivalente a: @current_user = @current_user || User.find....
    # si @current_user es true, este es regresado y dado que estamos
    # hablando de un OR la consulta a la BD ya no se realiza
    # clarito, ¿no?
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
end
