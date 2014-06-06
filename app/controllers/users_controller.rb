class UsersController < ApplicationController
				before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
				before_action :correct_user,   only: [:edit, :update]

				before_action :admin_user,     only: :destroy

				def index
								@users = User.paginate(page: params[:page])
				end

				def show
								@user = User.find(params[:id])
								@microposts = @user.microposts.paginate(page: params[:page])
				end


				def new
								@user = User.new
				end

				def edit
								@user = User.find(params[:id])
				end

				def update
								@user = User.find(params[:id])
								if @user.update_attributes(user_params)
												flash[:success] = "Profile updated"
												redirect_to @user
								else
												render 'edit'
								end
				end

				def create
								@user = User.new(user_params)
								if @user.save
												sign_in @user
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

				def correct_user
								@user = User.find(params[:id])
								redirect_to(root_url) unless current_user?(@user)
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

def destroy
				User.find(params[:id]).destroy
				flash[:success] = "User deleted."
				redirect_to users_url
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

def admin_user
				redirect_to(root_url) unless current_user.admin?
end
