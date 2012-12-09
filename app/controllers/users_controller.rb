class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  def new
    @user = User.new
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def create
    @user = User.new params[:user]
    if @user.save
      add_to_session @user
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

end
