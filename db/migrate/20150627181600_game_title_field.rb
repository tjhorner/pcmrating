class GameTitleField < ActiveRecord::Migration
  def change
    add_column :games, :title, :string

    Game.all.each do |game|
      title = game.data[game.data.keys[0]]['data']['name']
      game.update_column(:title, title)
    end

    change_column :games, :title, :string, :null => false
    add_index :games, :title
  end
end