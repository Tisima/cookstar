class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :recipes, dependent: :destroy
   has_one_attached :profile_image
   has_many :likes, dependent: :destroy
   has_many :recipe_comments, dependent: :destroy
   has_many :liked_recipes, through: :likes, source: :post
   has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
   has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

   has_many :followings, through: :relationships, source: :followed
   has_many :followers, through: :reverse_of_relationships, source: :follower

  def self.search(keyword)
  where(["name like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])
  end

  def liked_by?(recipe_id)
    likes.where(recipe_id: recipe_id).exists?
  end

  # フォローしたときの処理
  def follow(user_id)
  relationships.create(followed_id: user_id)
  end
# フォローを外すときの処理
  def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
  end
# フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
       profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end
end