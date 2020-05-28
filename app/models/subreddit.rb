class Subreddit < ApplicationRecord
    belongs_to :user
    has_many :posts
    has_many :user_subreddits
    has_many :users, through: :user_subreddits

    def top_posts
      self.posts.sort_by { |post| post.reputation }.reverse
    end

    def least_posts
      self.posts.sort_by { |post| post.reputation }
    end

    def total_posts 
        self.posts.size
    end

    def self.most_posts
        self.all.max{|a,b| a.total_posts <=> b.total_posts}
    end

    def user_total 
        self.user_subreddits.count
    end 

    def self.most_users
      self.all.max { |a, b| a.user_total <=> b.user_total }
    end 

end
