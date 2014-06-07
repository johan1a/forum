class TopicsController < ApplicationController
	before_filter :signed_in_user, :except => [:index, :show]
	before_filter :admin_required, :only => :destroy

	def index
		@topics = Topic.all
	end

	def show
		@topic = Topic.find(params[:id])
	end

	def new
		@topic = Topic.new #(:name => params[:topic][:name], :last_poster_id => current_user.id, :last_post_at => Time.now, :forum_id => params[:topic][:forum_id], :user_id => current_user.id)
	end 

	def create
		@topic = Topic.new(params[:topic])
		if @topic.save
			@topic = Topic.new(:name => params[:topic][:name], :last_poster_id => current_user.id, :last_post_at => Time.now, :forum_id => params[:topic][:forum_id], :user_id => current_user.id)

			if @post.save
				flash[:notice] = "Successfully created topic."
				redirect_to "/forums/#{@topic.forum_id}"
			else
				redirect :action => 'new'
			end
		else
			render :action => 'new'
		end
		before_filter :login_required, :except => [:index, :show]
		before_filter :admin_required, :only => :destroy
	end
end