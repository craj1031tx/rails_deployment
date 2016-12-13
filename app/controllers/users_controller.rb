class UsersController < ApplicationController
	before_action :require_login, except: [:create, :register]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

	def register
		render 'register'
	end
	def show
		@user = User.find(session[:user_id])

		render 'show'
	end

	def create
		user = User.new(receive_registration)
		if user.valid?
			user.save
			session[:user_id] = user.id
			redirect_to "/users/#{user.id}/"
		else
			flash[:errors] = user.errors
			redirect_to "/users/new/"
		end
	end

	def edit
		@user = User.find(params[:id])
		render 'edit'
	end

	def update
		user = User.find(params[:id])
		user.update(receive_edit)
		redirect_to "/users/#{user.id}/"
	end

	def destroy 
		User.find(params[:id]).destroy
		session[:user_id] = nil
		redirect_to "/sessions/new"
	end

	private
	def receive_registration
		params.require(:reg).permit(:name, :email, :password, :password_confirmation)
	end

	def receive_edit
		params.require(:edit).permit(:name, :email)
	end

end