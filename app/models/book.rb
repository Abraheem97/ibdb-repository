class Book < ApplicationRecord
  has_attached_file :image, styles: { medium: '250x300>' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  belongs_to :author
  has_many :reviews
  has_many :comments
end
