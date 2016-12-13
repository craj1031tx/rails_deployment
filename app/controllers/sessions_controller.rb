class SessionsController < ApplicationController
	def index
		render 'index'
	end

	def login
		user = User.find_by_email(params[:info]['email'])
		if user && user.authenticate(params[:info]['password'])
			session[:user_id] = user.id 
			redirect_to "/users/#{user.id}"
		else
			flash[:errors] = ["Invalid password!"]
			redirect_to :back #redirects straight back to the previous route
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to '/sessions/new'
	end


	private
	def get_login_info
		params.require(:info).permit(:email, :password)
	end
end
