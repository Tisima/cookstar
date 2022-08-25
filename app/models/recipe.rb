class Recipe < ApplicationRecord
  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_one_attached :image

# 検索方法分岐
  def self.looks(search, word)
    if search == "partial_match"
      @recipe = Recipe.where("title LIKE?","%#{word}%")
    else
      @recipe = Recipe.all
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
