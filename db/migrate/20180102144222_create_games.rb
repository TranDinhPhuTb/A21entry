class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :match, foreign_key: true
      t.integer :score
      t.references :winner, references: :teams, index: true

      t.timestamps
    end

    add_foreign_key :games, :teams, column: :winner_id
  end
end
