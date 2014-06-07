class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_filter :signed_in_user

	# GET /posts
	# GET /posts.json
	def index
		@posts = Post.all
	end

	# GET /posts/1
	# GET /posts/1.json
	def show
	end

	# GET /posts/new
	def new
		@post = Post.new
	end

	# GET /posts/1/edit


	def create
		@post = Post.new(:content => params[:post][:content], :topic_id => params[:post][:topic_id], :user_id => current_user.id)
		if @post.save
			@topic = Topic.find(@post.topic_id)
			@topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)

			@forum = Forum.find(@topic.forum_id)
			@forum.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)
			flash[:notice] = "Successfully created post."
			redirect_to @topic
		else
			render :action => 'new'
		end
	end

	def edit
		  @post = Post.find(params[:id])
		    admin_or_owner_required(@post.user.id)
	end
	 
	def update
		  @post = Post.find(params[:id])
		    admin_or_owner_required(@post.user.id)
		      if @post.update_attributes(params[:post])
			          @topic = Topic.find(@post.topic_id)
				      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)
				          flash[:notice] = "Successfully updated post."
					      redirect_to "/topics/#{@post.topic_id}"
					        else
						    render :action => 'edit'
						      end
						      end
						       
						      def destroy
						        @post = Post.find(params[:id])
							  admin_or_owner_required(@post.user.id)
							    @post.destroy
							      flash[:notice] = "Successfully destroyed post."
							        redirect_to forums_url
						      end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_post
		@post = Post.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def post_params
		params.require(:post).permit(:content)
	end
end
