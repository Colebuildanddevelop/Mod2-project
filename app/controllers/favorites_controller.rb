class FavoritesController < ApplicationController

    def create
        @user = User.find(session[:user_id])
        @post = Post.find(params[:post][:id])
        if !User.find(session[:user_id]).favorites.find_by(post_id: @post.id) 
            Favorite.create(user_id: @user.id, post_id: @post.id)
            @post.reputation += 1
            @post.save
            exist = true
        else 
            flash[:errors] = "You have already liked this post!" 
        end 
        redirect_to "/posts/#{@post.id}"
    end

    def destroy
        @post = Post.find(params[:post][:id])
        @post.reputation -= 1
        @post.save
        Favorite.find(params[:id]).destroy
        redirect_to "/posts/#{@post.id}"

    end


end
