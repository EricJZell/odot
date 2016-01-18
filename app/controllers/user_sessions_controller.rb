class UserSessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email].downcase if params[:email]
    user = User.find_by(email: email)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Thanks for logging in."
      redirect_to todo_lists_path
    else
      flash[:error] = "There was a problem logging in. Please check your email and password."
      render action: 'new'
    end
  end
end
