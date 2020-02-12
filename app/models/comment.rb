class Comment < ApplicationRecord
    validates :body, presence: true, allow_blank: false

    belongs_to :user
    belongs_to :book
end
