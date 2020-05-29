class Post < ApplicationRecord
    belongs_to :user
    belongs_to :subreddit
    has_many :comments

    has_many :favorites
    has_many :users, through: :favorites

    def self.top
        self.all.sort_by { |post| post.reputation }.reverse
    end

    def self.least
        self.all.sort_by { |post| post.reputation }
    end

    def self.most_commented
        self.all.max{|a, b| a.comments.count <=> b.comments.count}
    end 

    def format_content
        formatted_str_arr = []
        self.content.split(" ").each do |word|
            formatted_word = []
            word.split("").each do |char|
                if !((char == "[") || (char == "]") || (char == "\""))
                  formatted_word << char
                end 
            end
            formatted_str_arr << formatted_word.join("")
        end 
        formatted_str_arr.join(" ")
    end

end
