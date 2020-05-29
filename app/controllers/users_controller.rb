class UsersController < ApplicationController
    
    def show 
        @user = current_user
        if session[:filter]
          case session[:filter]
          when "top posts"
              @filter = {}
              @filter[:name] = "Top Posts"
              @filter[:array] = @user.top_posts
          when "worst posts"
              @filter = {
                  name: "Worst Posts",
                  array: @user.least_posts
              }
          when "comments"
              @filter = {
                  name: "Comments",
                  array: @user.comments
              }
          end
        end 
    end

    def new
        @user = User.new
    end

    def filter 
        @user = current_user
        session[:filter] = params[:filter]
        redirect_to @user 
    end 

    def create
        if params[:user][:profile_img_url] = ""
            @user = User.new(
            name: params[:user][:name],
            password: params[:user][:password],
            bio: params[:user][:bio],
            profile_img_url: "https://picsum.photos/id/#{rand(1..300)}/200"
            )
        else
            @user = User.new(
            name: params[:user][:name],
            password: params[:user][:password],
            bio: params[:user][:bio],
            profile_img_url: params[:user][:profile_img_url]
            )
        end

        if @user.valid?  
          if params[:user][:password] == params[:user][:confirm_password]
            @user.save
            session[:user_id] = @user.id 
            redirect_to "/"
          else 
            flash[:errors] = ["passwords did not match!"]
            redirect_to "/users/new"
          end 
        else
            flash[:errors] = @user.errors.full_messages 
            redirect_to "/users/new"
        end
    end

    def edit 
        @user = current_user
    end

    def update
        # byebug
        @user = current_user
        if session[:user_id] == @user.id
          @user.update(user_params)
          redirect_to @user
        else
          flash[:errors] = "You must be logged in as #{@user.name} to edit!"
          redirect_to "/users/#{@user.id}/edit"
        end 
    end

    def destroy 
        @user = current_user
        @user.posts.destroy_all
        # @user.subreddits.destroy_all
        @user.destroy
        session[:user_id] = nil
        redirect_to "/"
    end 

    def current_user 
        User.find(params[:id])
    end 

    private
    def user_params 
        params.require(:user).permit(:name, :password, :confirm_password, :bio, :profile_img_url)
    end 

    def login_params 
        params.require(:user).permit(:name, :password)
    end 


end
