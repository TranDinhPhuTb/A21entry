class HomeController < ApplicationController
	WINS_GAME_CONDITION = 2
	def index
		teams = Team.all
		matchs = Match.all
		games = Game.all
		matchs_count = matchs.count
		@teams = []
		teams.each do |team|
			current_team = {}
			current_team["id"] = team.id
			current_team["name"] = team.name
			relevant_matchs = matchs.select{|m| m.team_a_id == team.id || m.team_b_id == team.id}
			current_team["match_play"] = relevant_matchs.count
			wins = 0
			relevant_matchs.each do |match|
				if games.select{|game| game.match_id == match.id && winner_id = team.id}.count >= WINS_GAME_CONDITION
					wins += 1
				end
			end
			current_team["win_ratio"] = wins / relevant_matchs.count.to_f
			@teams.push	current_team
		end
		@teams = @teams.sort_by{|team| team["win_ratio"]}.reverse
	end
end
