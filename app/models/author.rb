class Author < ApplicationRecord
  has_attached_file :image, styles: { medium: '250x300>' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  has_many :books, dependent: :destroy
end
