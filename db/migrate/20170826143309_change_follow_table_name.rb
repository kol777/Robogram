class ChangeFollowTableName < ActiveRecord::Migration[5.0]
  def change
    rename_table :follow, :follows
  end
end
