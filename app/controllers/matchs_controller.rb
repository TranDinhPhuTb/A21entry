class MatchsController < ApplicationController
	def index
		@matchs = Match.all
	end

	def new
		@match = Match.new
		@list_teams = Team.all.collect{|item| [item.name, item.id]}
	end

	def create
		@match = Match.new
		@match.team_a_id = params[:match][:team_a_id]
		@match.team_b_id = params[:match][:team_b_id]
		@match.save
		if params[:game].any?
			params[:game].each do |game|
				if !game[:winner].present? || !game[:score].present?
					next
				end
				current_game = Game.new
				current_game.match_id = @match.id
				current_game.winner_id = game[:winner]
				current_game.score = game[:score]
				current_game.save
			end
		end
		redirect_to action: "edit", id: @match.id
	end

	def edit
		@match = Match.find(params[:id])
		@list_teams = Team.all.collect{|item| [item.name, item.id]}
		@games = @match.games
	end

	def update
		@match = Match.find(params[:id])
		@match.team_a_id = params[:match][:team_a_id]
		@match.team_b_id = params[:match][:team_b_id]
		@match.save
		if params[:game].any?
			params[:game].each do |game|
				if !game[:winner].present? || !game[:score].present?
					next
				end
				if game[:id].present?
					current_game = Game.find(game[:id])
				else
					current_game = Game.new
				end
				current_game.match_id = @match.id
				current_game.winner_id = game[:winner]
				current_game.score = game[:score]
				current_game.save
			end
		end
		redirect_to action: "edit", id: @match.id
	end
end
