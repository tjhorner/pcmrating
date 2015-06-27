class AddReviewToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :review, :string
  end
end
