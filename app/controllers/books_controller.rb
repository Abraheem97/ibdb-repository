# Controller for books
class BooksController < ApplicationController
	before_action :find_book, only: %i[show edit destroy update upvote add_author show_author] 
	load_and_authorize_resource
	skip_before_action :authenticate_user!, only: %i[index show]
	
						
	def index
		@books = Book.all
	end

	def show
		@comment = Comment.new
		@comments = @book.comments.order('created_at DESC')
		@reviews = @book.reviews
				
		if @reviews.blank?
			@avg_review = 0
			@emptystars = 5
		else
			@avg_review = @reviews.average(:rating).floor
			@emptystars = 5 - @avg_review.to_i
		end
	end
		
	def new # for moderator only, admin and sadmin will use dashoboard to create
		unless user_signed_in? && current_user.moderator_role == true
			redirect_to root_path
		end
		@book = Book.new()
	end
		
	def create
		@book = Book.create(book_params)
		@author = Author.find_or_create_by(name: @book.author_name)
		@book.author = @author
		@book.save	
		redirect_to @book, notice: 'Successfully created book'
	end
									
	def edit; end

	def update
		if @book.update(book_params)
			redirect_to @book, notice: 'book was successfully updated'
		else
			render 'edit'
		end
	end
							
	def destroy
		@book.destroy
		redirect_to root_path
	end

	def show_author
		@author = @book.author
	end										
	
	private
		def book_params
			params.require(:book).permit(:title,:author_name,:image)
		end
							
	def find_book
		@book = Book.find(params[:id])
	end

end
