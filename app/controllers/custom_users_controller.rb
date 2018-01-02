class CustomUsersController < ApplicationController
	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.email = params[:user][:email]
		@user.first_name = params[:user][:first_name]
		@user.last_name = params[:user][:last_name]
		@user.save
		redirect_to action: "edit", id: params[:id]
	end
end
