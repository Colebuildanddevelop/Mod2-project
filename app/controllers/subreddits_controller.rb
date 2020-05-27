class SubredditsController < ApplicationController
    
    
    def show 
      if session[:user_id]
        @user = User.all.find(session[:user_id])
      end 
      @subreddit = current_subreddit
    end

    def new
      @subreddit = Subreddit.new
    end

    def create
      if session[:user_id]
        sub = Subreddit.create(sub_params)
        sub.user_id = session[:user_id]
        sub.save
        redirect_to sub
      else 
        flash[:errors] = "must be logged in to create a subreddit"
        redirect_to "/subreddits/new"
      end 
    end

    def destroy
      sub = current_subreddit
      if session[:user_id] == sub.user.id
        sub.destroy
        redirect_to "/"
      else 
        flash[:errors] = "must be owner of subreddit to destroy"
        redirect_to sub
      end 
    end

    def update
      subreddit = current_subreddit
      user = User.find(session[:user_id])

      if !subreddit.users.include?(user)
        subreddit.users << user
        redirect_to subreddit
      else 
        joiner = subreddit.user_subreddits.select do |ur|
          user.id == ur.user_id          
        end 
        joiner[0].destroy
        redirect_to subreddit
      end 
    end 

    def current_subreddit 
      Subreddit.find(params[:id])
    end 

    private
    def sub_params 
        params.require(:subreddit).permit(:name, :description)
    end 
    
end
