class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_book






  def new
    @comment = Comment.new
  end
  

  def edit
  end


  def create
    @comment = @book.comments.new(comment_params)
    @comment.user = current_user
    

    @comment.save
             
  
          
 
  end


  def update
    
      if @comment.update(comment_params)
        redirect_to @comment, notice: 'Comment was successfully updated.' 
        
      else
        render :edit 
        
      end
    
  end

  def destroy
    @comment.destroy
    
      redirect_to comments_url, notice: 'Comment was successfully destroyed.' 
  end
    def set_comment
      @comment = Comment.find(params[:id])
    end

    
    def comment_params
      params.require(:comment).permit(:body)
    end
    def set_book
      @book = Book.find(params[:book_id])
    end
end
