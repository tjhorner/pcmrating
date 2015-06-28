class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_location
  before_filter :banned?

  def store_location
    return unless request.get?

    ignored_urls = [
      '/users/sign_in', '/users/sign_up', '/users/password/new',
      '/users/password/edit', '/users/confirmation', '/users/sign_out'
    ]

    return if ignored_urls.include?(request.path) || request.xhr?

    session[:previous_url] = request.fullpath
  end

  def after_sign_in_path_for(_resource)
    session[:previous_url] || root_path
  end

  def banned?
    return unless current_user && current_user.banned?
    redirect_to 'https://www.google.co.uk/webhp#q=you%27vebeenbanned'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :username
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

end
