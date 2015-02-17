class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user #CHANGE WITH AUTHENTICATION

    if @comment.save
      flash[:notice] = "Comment was saved"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])
    Vote.create(voteable: comment, user: current_user, vote: params[:vote])
    flash[:notice] = "you voted"
    redirect_to :back
  end
end