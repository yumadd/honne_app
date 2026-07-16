class Post < ApplicationRecord
  # 1つの投稿は、たくさんのコメントを持つ（ぶら下げる）よという魔法
  has_many :comments, dependent: :destroy
end