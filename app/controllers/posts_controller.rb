class PostsController < ApplicationController
    
    def show 
      @comment = Comment.new
      @exist = false
      @post = current_post
    end

    def current_post 
      Post.find(params[:id])
    end 

    def new 
      @post = Post.new
      @subreddits = Subreddit.all
    end 

    def create
      if session[:user_id] 
        @post = Post.new(post_params)
        @post.reputation = 0
        @post.user_id = session[:user_id]
        @post.save
        redirect_to "/posts/#{@post.id}"
      else 
        flash[:errors] = "Warning! Must be logged in to create a post!"
        redirect_to "/posts/new"
      end 
    end 
    
    def destroy
      post = current_post
      if session[:user_id] == post.user.id
        post.destroy
        redirect_to '/'
      else 
        flash[:errors] = "Only the owner of the post can delete!"
        redirect_to post
      end
    end 

    private
    def post_params 
        params.require(:post).permit(:title, :content, :subreddit_id)
    end

end
