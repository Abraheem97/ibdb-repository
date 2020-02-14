class Comment < ApplicationRecord
  validates :body, presence: true, allow_blank: false
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  belongs_to :user
  belongs_to :book
end
