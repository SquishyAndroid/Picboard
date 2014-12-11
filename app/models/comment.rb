class Comment < ActiveRecord::Base
	Paperclip.options.merge!(:command_path => 'C:/Program Files/ImageMagick-6.8.9-Q16')
	
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }


  belongs_to :user
  belongs_to :post
  acts_as_votable
end
