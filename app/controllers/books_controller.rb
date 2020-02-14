class BooksController < ApplicationController

    before_action :find_book, only: [:show,:edit,:destroy,:update,:upvote,:add_author,:show_author] 
    

   
    
def index
    #if params[:search]
    #@books = book.by_title(params[:search])
    #else
    @books = Book.all
    #end          
end
        
def show 
    #@user = @book.user            
    @comment = Comment.new
    @comments = @book.comments.order("created_at DESC")
    @reviews = @book.reviews
            
    if @reviews.blank?
        @avg_review = 0
        @emptystars = 5
    else
        @avg_review = @reviews.average(:rating).floor
        @emptystars = 5 - @avg_review.to_i
    end 
              
end
    
def new
    unless user_signed_in? && current_user.superadmin == true 
        redirect_to root_path
    end
    @book = Book.new()
    #@book = current_user.books.build 
end

       
    
def create             
    #@book = current_user.books.build(book_params)
    @book = Book.create(book_params)
           
    if Author.exists?(name: @book.author_name)
        @book.author = Author.find_by_name(@book.author_name)
        @book.save
    else
        @author = Author.create(name: @book.author_name)
        @author.save
        @book.author = @author
        @book.save            
    end
    redirect_to @book, notice: "Successfully created book"           
end
        
def edit 
end
    
def update
    if @book.update(book_params) 
        redirect_to @book, notice: "book was successfully updated"
    else
        render 'edit'
    end
end
    
def destroy
    @book.destroy
    #respond_to do |format|
    #   format.js
    redirect_to root_path            
end
        
        # def upvote            
        #     @book.upvote_by current_user 
        #     respond_to do |format|
        #         format.js
        # end
            
        # end

        # def showuser

        #     book = book.find(params[:id])
        #     @book_user = User.find(book.user_id) 
        # end

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
