class CreateTeamPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :team_players do |t|
      t.references :team, foreign_key: true, index: true
      t.references :player, foreign_key: true, index: true

      t.timestamps
    end
  end
end
