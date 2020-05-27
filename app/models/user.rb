class User < ApplicationRecord
    has_many :user_subreddits
    has_many :posts
    has_many :comments
    has_many :subreddits, through: :user_subreddits
    has_many :subreddits, through: :posts
    has_many :subreddits
    has_many :favorites
    # has_many :posts, through: :favorites

    def total_rep
        self.posts.map { |post| post.reputation }.sum
    end

    def top_posts
      self.posts.sort_by { |post| post.reputation }.reverse
    end 

    def least_posts
      self.posts.sort_by { |post| post.reputation }.reverse
    end 

    def self.top_user
        self.all.max{|a, b| a.total_rep <=> b.total_rep}
    end

    def self.least_popular
        self.all.min{|a, b| a.total_rep <=> b.total_rep}
    end 

    def total_comments
        self.comments.size
    end    

    def self.most_comments
        self.all.max{|a, b| a.total_comments <=> b.total_comments}
    end

    def total_posts
       self.posts.length
    end 

    def self.most_posts
        self.all.max{|a, b| a.total_posts <=> b.total_posts }
    end 

end

