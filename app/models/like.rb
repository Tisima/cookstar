class Like < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates_uniqueness_of :post_id, scope: :user_id
end
