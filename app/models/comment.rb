class Comment < ActiveRecord::Base
	
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }


  belongs_to :user
  belongs_to :post
  acts_as_votable
end
