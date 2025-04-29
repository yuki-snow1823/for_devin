class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.references :user, null: true, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.boolean :is_ai
      t.string :guess

      t.timestamps
    end
  end
end
