class Post < ApplicationRecord
    belongs_to :user
    belongs_to :subreddit
    has_many :comments

    has_many :favorites
    has_many :users, through: :favorites

    def self.top
        Post.all.sort_by { |post| post.reputation }.reverse
    end

    def self.least
        Post.all.sort_by { |post| post.reputation }
    end

end
