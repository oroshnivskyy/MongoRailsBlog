class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  def new
  end

  def create
    user = User.authenticate params[:email], params[:password]
    if user
      add_to_session user
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end
end
