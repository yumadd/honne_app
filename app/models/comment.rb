class Comment < ApplicationRecord
  # このコメントがどのつぶやき（親）に紐づいているか
  belongs_to :post

  # 📥 返信（孫）から見た「元のコメント（親コメント）」を繋ぐ設定
  belongs_to :parent, class_name: "Comment", optional: true

  # 📤 元のコメントから見た「たくさんの返信（孫コメント）」をぶら下げる設定
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :content, presence: true
end
