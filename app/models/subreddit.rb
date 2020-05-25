class Subreddit < ApplicationRecord
    has_many :posts
    has_many :user_subreddits
    has_many :users, through: :user_subreddits
end
