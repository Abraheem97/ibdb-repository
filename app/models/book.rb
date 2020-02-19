class Book < ApplicationRecord
  scope :by_title, -> (title) { where("title LIKE '%#{title}%'") }
  scope :by_author,-> (author) { where("author_name LIKE '%#{author}%'")}
  scope :by_both, -> (search) { where("author_name LIKE '%#{search}%' OR title LIKE '%#{search}%'") }
   
  has_attached_file :image, styles: { medium: '250x300>' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  belongs_to :author
  has_many :reviews
  has_many :comments
end
