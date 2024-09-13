class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user

  private

  def current_user
    @current_user ||= Usuario.find(session[:usuario_id]) if session[:usuario_id]
  end
end
