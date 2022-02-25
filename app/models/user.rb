class User < ApplicationRecord
  enum role: %i[user moderator admin]
  has_many :rooms, dependent: :destroy
  has_many :messages, -> { sorted }, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [40, 40]
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_commit :add_default_avatar, on: %i[create update]

  def username
    email.split('@').first.parameterize.split('-').join(' ').titlecase
  end

  def profile_avatar
    avatar.variant(resize_to_limit: [100, 100]).processed
  end

  def favorited?(room)
    favorites.find_by(room: room).present?
  end

  private

  def add_default_avatar
    return if avatar.attached?

    avatar.attach(
      io: File.open(Rails.root.join('app', 'assets', 'images', 'Unknowns_user_avatar.png')),
      filename: 'Unknowns_user_avatar.png',
      content_type: 'image/png'
    )
  end
end
