class AddUniqueSlugToGame < ActiveRecord::Migration
  def change
    add_column :games, :slug, :string, unique: true
    add_index :games, :slug, unique: true

    Game.find_each(&:save)
  end
end
