class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :token_authenticatable

  # Associations
  has_many :tweets
  has_many :authentication_tokens
  has_many :active_relationships, class_name:  'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id).present?
  end

  def follow_user!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def unfollow_user!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy!
  end
end
