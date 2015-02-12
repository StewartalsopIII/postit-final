class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = User.first #CHANGE WITH AUTHENTICATION

    if @comment.save
      flash[:notice] = "Comment was saved"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end