class Tweet < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :content, presence: true, length: { maximum: 140 }
end
