class CommentsController < ApplicationController
  # コメントを新しく保存する処理
  def create
    # どのつぶやき（親）に対するコメントかを探し出す
    @post = Post.find(params[:post_id])
    # そのつぶやきに紐づいた新しいコメントを作る
    @comment = @post.comments.build(comment_params)

    if @comment.save
      # 保存に成功したら、そのつぶやきの「詳細画面」に戻る
      redirect_to post_path(@post), notice: "コメントを投稿しました！"
    else
      # 失敗した場合も詳細画面に戻る
      redirect_to post_path(@post), alert: "コメントの投稿に失敗しました。"
    end
  end

  private
    # コメント専用の門番（ストロングパラメーター）
    def comment_params
      params.require(:comment).permit(:content, :parent_id)
    end
end