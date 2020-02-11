class Author < ApplicationRecord
    has_many :books, dependent: :destroy  #if the author is destroyed all books also get destroyed
end
