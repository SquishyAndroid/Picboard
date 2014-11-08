class Post < ActiveRecord::Base
	Paperclip.options[:command_path] = 'C:/Program Files/ImageMagick-6.8.9-Q16'
	acts_as_votable
	belongs_to :user

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }

	validates :image, presence: true
end
