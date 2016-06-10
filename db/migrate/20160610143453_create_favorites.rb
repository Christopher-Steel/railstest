class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :number, limit: 8

      t.timestamps null: false
    end
  end
end
