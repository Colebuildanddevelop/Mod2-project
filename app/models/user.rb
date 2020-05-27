class User < ApplicationRecord
    
    has_many :user_subreddits
    has_many :posts
    has_many :comments
    has_many :subreddits, through: :user_subreddits
    has_many :subreddits, through: :posts
    has_many :subreddits

    has_many :favorites
    has_many :posts, through: :favorites

end

