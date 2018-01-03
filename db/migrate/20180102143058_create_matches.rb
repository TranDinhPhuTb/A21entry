class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.references :team_a, references: :teams, index: true
      t.references :team_b, references: :teams, index: true

      t.timestamps
    end
    
	add_foreign_key :matches, :teams, column: :team_a_id
	add_foreign_key :matches, :teams, column: :team_b_id
  end
end
