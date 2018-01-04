class MatchsController < ApplicationController
include Constant
	def index
		@matchs = Match.all
	end

	def new
		@match = Match.new
		@list_teams = Team.all.collect{|item| [item.name, item.id]}
	end

	def create
		create_is_invalid = MatchService.new.create_invalid?(params: params)
		if create_is_invalid
			flash[:err] = create_is_invalid
			redirect_to action: "new"
			return
		end
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
		@max_game_per_match = MAX_GAME_PER_MATCH
	end

	def update
		@match = Match.find(params[:id])
		update_is_invalid = MatchService.new.update_invalid?(params: params)
		if update_is_invalid
			flash[:err] = update_is_invalid
			redirect_to action: "edit", id: @match.id
			return
		end
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
