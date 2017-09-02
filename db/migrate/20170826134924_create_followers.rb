class CreateFollowers < ActiveRecord::Migration[5.0]
  def change
    create_table 'follow' do |t|
      t.integer 'following_id', :null => false
      t.integer 'follower_id', :null => false

      t.timestamps null: false
    end

    add_index :follow, :following_id
    add_index :follow, :follower_id
    add_index :follow, [:following_id, :follower_id], unique: true
  end
end
