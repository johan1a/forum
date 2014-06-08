class TopicsController < ApplicationController
	before_filter :signed_in_user, :except => [:index, :show]
	before_filter :admin_required, :only => :destroy

	def index
		@topics = Topic.all
	end

	def show
		@topic = Topic.find(params[:id])
		@posts = @topic.posts.order("created_at desc").paginate(:page => params[:page])
	end

	def new
		@topic = Topic.new
	end 

	def create
		@topic = Topic.new(:name => params[:topic][:name], :last_poster_id => current_user.id, :last_post_at => Time.now, :forum_id => params[:topic][:forum_id], :user_id => current_user.id)
		if @topic.save
				flash[:notice] = "Successfully created topic."
				redirect_to new_post_url(topic: @topic.id)
		else
			render :action => 'new'
		end
	end
end