class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
      # flash[:success] = "Commented successfully!"
      # redirect_to :back
    else
      flash[:alert] = "Something went wrong."
      render root_path
    end
  end

  def destroy
    @post = Post.find(params[:post_id]) # get post id
    @comment = @post.comments.find(params[:id])

    if @comment.user_id == current_user.id
      @comment.delete
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
