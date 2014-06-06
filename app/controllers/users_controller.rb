class UsersController < ApplicationController
		before_action :set_user, only: [:show, :edit, :update, :destroy]

		def index
				@users = User.all
		end

		def show
		end


		def new
				@user = User.new
		end


		def edit
		end


		def create
				@user = User.new(user_params)
				if @user.save
						flash[:success] = 'Welcome to the Sample App!'

						redirect_to @user
				else
						render 'new'
				end
		end

		def user_params
				params.require(:user).permit(:name, :email, :password,
											 :password_confirmation)
		end

		respond_to do |format|
				if @user.save
						format.html { redirect_to @user, notice: 'User was successfully created.' }
						format.json { render :show, status: :created, location: @user }
				else
						format.html { render :new }
						format.json { render json: @user.errors, status: :unprocessable_entity }
				end
		end
end

# PATCH/PUT /users/1
# PATCH/PUT /users/1.json
def update
		respond_to do |format|
				if @user.update(user_params)
						format.html { redirect_to @user, notice: 'User was successfully updated.' }
						format.json { render :show, status: :ok, location: @user }
				else
						format.html { render :edit }
						format.json { render json: @user.errors, status: :unprocessable_entity }
				end
		end
end

# DELETE /users/1
# DELETE /users/1.json
def destroy
				sign_out
				redirect_to root_url
end

private
# Use callbacks to share common setup or constraints between actions.
def set_user
		@user = User.find(params[:id])
end

# Never trust parameters from the scary internet, only allow the white list through.
def user_params
		params.require(:user).permit(:name, :email)
end
