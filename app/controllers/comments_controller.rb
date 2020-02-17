# Controller for comments
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit destroy update]
  before_action :set_book
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    @comment = @book.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to book_path(@book) unless @comment.parent_id.nil?
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
    redirect_to @book, notice: 'Comment was successfully destroyed.'
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end