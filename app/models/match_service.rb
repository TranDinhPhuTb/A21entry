class MatchService
	def create_invalid?(func_params = {})
		params = func_params[:params]
		err = []
		if !params[:match][:team_a_id].present?
			err.push "First team is missing"
		end
		if !params[:match][:team_b_id].present?
			err.push "Second team is missing"
		end
		if params[:match][:team_a_id] == params[:match][:team_b_id]
			err.push "First team and second team must be different"
		end

		relevant_games = params[:game].select{|game| game[:winner].present? && game[:score].present?}
		if relevant_games.count < 2
			err.push "Please input enough games info"
		end

		if relevant_games.select{ |game| !game[:winner].in?([params[:match][:team_a_id], params[:match][:team_b_id]]) }.any?
			err.push "Wrong team is input in game info"
		end

		if relevant_games.select{ |game| !game[:score].to_i.in?((0..10)) }.any?
			err.push "Incorrect score number"
		end

		most_wins = max_count(relevant_games.map{|game| game[:winner]})
		if most_wins < 2
			err.push "Game info is not enough to decide winner"
		end
		
		if err.any?
			return err
		end
		return false
	end

	def update_invalid?(*params)
		create_invalid?(*params)
	end

	private

	def max_count(arr)
		arr.uniq.map { |n| Rails.logger.info arr.count(n) ; arr.count(n) }.max
	end
end