class Micropost < ActiveRecord::Base
		belongs_to :user
		default_scope -> { order('created_at DESC') }
		validates :content, presence: true, length: { maximum: 140 }
		validates :user:id, presence: true
end
