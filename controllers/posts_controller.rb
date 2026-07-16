class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy like ]

  # タイムライン（一覧画面）
  def index
    if params[:category].present?
      @posts = Post.where(category: params[:category]).order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  # 詳細画面
  def show
  end

  # 新規投稿画面
  def new
    @post = Post.new
  end

  # 編集画面
  def edit
  end

  # 新しくホンネを保存する処理
  def create
    @post = Post.new(post_params)

    # 投稿するたびにランダムでパステルカラーの背景色を決定してセットする魔法
colors = %w[ #FFF0F2 #F0F5FF #F3E8FF #E8FFFA #FFFDE8 #F5FFE8 ]
    @post.bg_color = colors.sample

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: "ホンネをタイムラインにつぶやきました！" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # ホンネを更新する処理
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # 投稿を1件だけ削除する処理
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "ホンネを1件削除しました。" }
    end
  end

  # 「わかる！」ボタンの処理（絶対に上に動かないJavaScript連動仕様）
  def like
    @post.likes_count = (@post.likes_count || 0) + 1
    @post.save
    head :no_content
  end

  # すべての投稿を一発で消し去る全削除処理
  def destroy_all
    Post.destroy_all
    redirect_to posts_path, notice: "すべてのホンネを綺麗に消去しました！"
  end

  private
    # 共通の投稿データを見つける処理
    def set_post
      @post = Post.find(params[:id])
    end

    # 🛡️ 門番（すべてのデータ：本文、背景色、カテゴリー、スタンプを通します！）
    def post_params
      params.require(:post).permit(:content, :bg_color, :category, :emotion)
    end
end