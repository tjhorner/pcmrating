class CreateGamesTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :steam_appid
      t.string :data
    end
  end
end
