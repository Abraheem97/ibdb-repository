class Review < ApplicationRecord
    validates :comment, presence: true, allow_blank: false
    validates :rating, presence: true, allow_blank: false

    belongs_to :user
    belongs_to :book
    
end
