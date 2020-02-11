class Book < ApplicationRecord
    has_attached_file :image, :styles => { :medium => "100%x200>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  belongs_to :author
end
