class CommentsController < ApplicationController
   
    def create 
      @post = Post.find(params[:post_id])  
      if session[:user_id]
        Comment.create(comment_params)
        redirect_to @post

      else
        flash[:errors] = "You must be logged in to create a comment!"
        redirect_to @post
      end
    end 

    def delete
    
    end

    private 
    def comment_params
        params.permit(:post_id, :user_id, :content)
    end 

end
