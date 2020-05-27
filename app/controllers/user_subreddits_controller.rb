class UserSubredditsController < ApplicationController
    def show 
      @subreddit = current_subreddit
    end
    def current_subreddit 
      Subreddit.find(params[:id])
    end 
end
