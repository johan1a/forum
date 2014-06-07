class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include SessionsHelper
	def admin_required
		unless current_user && (current_user.permission_level == 1 || current_user.id == 1)
			redirect_to '/'
		end
	end

	def admin_or_owner_required(id)
		unless current_user.id == id || current_user.permission_level == 1 || current_user.id == 1
			redirect_to '/'
		end
	end
end
