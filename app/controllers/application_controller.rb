class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :require_login

  def add_to_session (user)
    session[:user_id] = user._id
  end

  private
  def current_user
    @current_user ||=User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to do this action"
      redirect_to root_url
    end
  end

  def logged_in?
    !!current_user
  end

end
