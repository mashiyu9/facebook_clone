class CommentsController < ApplicationController
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.build(comment_params)
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to picture_path(@picture), notice: '投稿できませんでした...' }
      end
    end
  end

  def show
    @comments = @picture.comments
    @comment = @picture.comments.build
  end

  private

  def comment_params
    params.require(:comment).permit(:picture_id, :content)
  end
end
