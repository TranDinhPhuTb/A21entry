class TeamsController < ApplicationController
	def index
		@teams = Team.all
	end

	def new
		@team = Team.new
	end

	def create
		@team = Team.new
		@team.name = params[:team][:name]
		@team.save
		redirect_to action: "edit", id: @team.id
	end

	def edit
		@team = Team.find(params[:id])
	end

	def update
		@team = Team.find(params[:id])
		@team.name = params[:team][:name]
		@team.save
		redirect_to action: "edit", id: @team.id
	end
end
