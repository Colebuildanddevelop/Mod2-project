class CreateUserSubreddits < ActiveRecord::Migration[6.0]
  def change
    create_table :user_subreddits do |t|
      t.integer :user_id
      t.integer :subreddit_id
      t.timestamps
    end
  end
end
