class UsersController < ApplicationController

    def show 
        @user = current_user
    end

    def new
        @user = User.new
    end

    def create
         @user = User.create(user_params)
         session[:user_id] = @user.id 
         redirect_to "/"
    end

    def edit 
        @user = current_user
    end

    def update
        @user = current_user
        if session[:id] == @user.id
          @user.update(user_params)
          redirect_to @user
        else
          flash[:errors] = "You must be logged in as #{@user.name} to edit!"
          redirect_to "/users/#{@user.id}/edit"
        end 
    end

    def destroy 
        @user = current_user
        @user.destroy
        redirect_to "/"
    end 

    def current_user 
        User.find(params[:id])
    end 

    private
    def user_params 
        params.require(:user).permit(:name, :password, :bio, :profile_img_url)
    end 

    def login_params 
        params.require(:user).permit(:name, :password)
    end 


end
