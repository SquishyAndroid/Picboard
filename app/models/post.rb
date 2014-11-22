class Post < ActiveRecord::Base
	Paperclip.options[:command_path] = 'C:/Program Files/ImageMagick-6.8.9-Q16'
	acts_as_votable
	belongs_to :user
	has_many :comments, :order => 'created_at DESC'

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }

	validates :image, presence: true


	def next
  	Post.where(["id < ?", id]).order(:id).last
	end

	def previous
	  Post.where(["id > ?", id]).order(:id).first
	end

end
