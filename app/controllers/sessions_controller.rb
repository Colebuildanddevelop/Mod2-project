class SessionsController < ApplicationController
    
  def new
    @user = User.new
  end 

  def create
    # byebug
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.password == params[:user][:password]
        session[:user_id] = @user.id  
       redirect_to '/'
      else
        # set errors
        flash[:errors] = "Username or password is wrong"
        redirect_to '/login'
      end 
    end 
  end

  def destroy 
    session.delete :user_id
    redirect_to "/"
  end 



end
