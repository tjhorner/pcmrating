class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :framerate
      t.integer :resolution
      t.integer :optimization
      t.integer :mods
      t.integer :servers
      t.integer :dlc
      t.integer :bugs
      t.integer :settings
      t.integer :controls
      t.integer :game_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
