class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user 

    if @comment.save
      flash[:notice] = "Comment was saved"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, user: current_user, vote: params[:vote])
    
    respond_to do |format|
      format.html do 
        if @vote.valid?
          flash[:notice] = "you voted"
        else
          flash[:error] = 'you can only vote once'
        end
        redirect_to :back
      end
      format.js
    end
  end

end