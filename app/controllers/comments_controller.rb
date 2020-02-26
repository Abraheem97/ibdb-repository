# Controller for comments
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit destroy update]
  before_action :set_book

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    @comment = @book.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    unless @comment.parent_id.nil?
      @reply = @comment
    end
    respond_to do |format|
      format.js { [@comment, @reply] }      
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @book, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js { @comment }
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id, :image)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

end