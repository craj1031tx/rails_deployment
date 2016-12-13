class SecretsController < ApplicationController
	before_action :require_login, only:[:index, :create, :destroy]
	def index
		@secrets = Secret.all 
		render 'index_secrets'
	end

	def create
		secret = User.find(session[:user_id]).secrets.create(receive_secret)
		redirect_to "/users/#{session[:user_id]}"
	end

	def destroy 
		secret = Secret.find(params[:id])
		secret.destroy if secret.user == current_user
		redirect_to "/users/#{session[:user_id]}"
	end

	def like
		Secret.find(params[:id]).likes.create(user_id:session[:user_id])
		redirect_to :back
	end

	def unlike
		Like.find(params[:id]).destroy
		redirect_to :back
	end

	private

	def receive_secret
		params.require(:secret).permit(:content)
	end
end
