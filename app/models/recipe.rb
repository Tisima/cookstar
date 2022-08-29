class Recipe < ApplicationRecord
  belongs_to :user, optional: true
  has_many :likes, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_one_attached :image


def self.search(keyword)
  where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
