class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :item_comments, dependent: :destroy
  attachment :profile_image

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id",dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  
  
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  default_scope -> { order(created_at: :desc) }

  validates :name, length: {maximum: 20, minimum: 1}
  validates :introduction, length: {maximum: 50}
end
