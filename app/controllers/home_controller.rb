class HomeController < ApplicationController

    def index 
        @subreddits = Subreddit.all
        @posts = Post.all 
    end

    def top 
        @top_p = Post.top 
    end

    def least
        @least_p = Post.least
    end

    def scores
        @users = User.all
        @subreddits = Subreddit.all
        @posts = Post.all
    end




end
