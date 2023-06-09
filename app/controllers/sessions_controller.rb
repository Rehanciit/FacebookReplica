class SessionsController < ApplicationController
    def new
    end
  
  def create
      user = User.find_by(name: params[:name])
      if user && user.password==(params[:password])
        session[:user_id] = user.id
        redirect_to root_url, notice: "Logged in successfully."
      else
        redirect_to login_url, alert: "Wrong Username Password!"
      end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out successfully.'
  end
end
 