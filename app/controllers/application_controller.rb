class ApplicationController < ActionController::Base
  helper_method :current_user

  # before_action :authenticate_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authenticate_user
    if current_user
      current_user
    else
      redirect_to root_path
    end
  end

end
