class UserSubreddit < ApplicationRecord
    belongs_to :user 
    belongs_to :subreddit 
end
