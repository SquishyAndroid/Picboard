class Post < ActiveRecord::Base
	acts_as_votable
	acts_as_taggable
	belongs_to :user
	has_many :comments

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }

	validates :image, presence: true
	validates :description, presence: true

	extend FriendlyId
  friendly_id :description, use: :slugged

	
	def next
	  	Post.where(["id < ?", id]).order(:id).last
		end

		def previous
		  Post.where(["id > ?", id]).order(:id).first
	end


end
