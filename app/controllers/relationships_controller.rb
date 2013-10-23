class RelationshipsController < ApplicationController

	def create
		@team = Team.find(params[:relationship][:team_id])
		@team.join!(current_user)
		redirect_to @team
	end

	def destroy
	  @relationship = Relationship.find(params[:id])
	  @team = @relationship.team
	  @relationship.destroy
	  redirect_to @team
	end

end