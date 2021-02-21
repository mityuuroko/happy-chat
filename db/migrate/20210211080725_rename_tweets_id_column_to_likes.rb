class RenameTweetsIdColumnToLikes < ActiveRecord::Migration[6.0]
  def change
    rename_column :likes, :tweets_id, :tweet_id
  end
end
