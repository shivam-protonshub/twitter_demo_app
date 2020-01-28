class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :token_authenticatable

  # Associations
  has_many :tweets
  has_many :authentication_tokens
  # Association for friendship for follow unfollow
  has_many :active_friendships, class_name:  'Friendship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_friendships, class_name: 'Friendship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_friendships, source: :followed
  has_many :followers, through: :passive_friendships, source: :follower

  def following?(other_user)
    active_friendships.find_by(followed_id: other_user.id).present?
  end

  def follow_user!(other_user)
    unless self == other_user
      active_friendships.create!(followed_id: other_user.id)
    else
      return false
    end
  end

  def unfollow_user!(other_user)
    unless self == other_user
      active_friendships.find_by(followed_id: other_user.id).destroy!
    else
      return false
    end
  end
end
