class Item < ApplicationRecord
  belongs_to :user
  attachment :image
  enum genre_name: {Pen: 0,Notebook: 1 ,Scissors: 2,Pins: 3, Pencilcase: 4,postcard: 5,other: 6 }

  has_many :favorites, dependent: :destroy
	has_many :item_comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
