class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :poster
      t.string :omdb_id

      t.timestamps
    end
  end
end
