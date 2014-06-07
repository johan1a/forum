class AddForeignToForums < ActiveRecord::Migration
	def change
		add_column :forums, :last_poster_id, :integer 
		add_column :forums, :last_post_at,  :datetime 
	end
end