class Room < ApplicationRecord
  include GenerateName
  has_many :messages, -> { sorted }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user

  enum chat_type: %i[common personal].freeze, _default: 0

  validates :chat_type, presence: true, inclusion: { in: chat_types.stringify_keys.keys }

  before_create :generate_public_title, if: Proc.new { common? }
  after_create_commit :generate_random_name, if: Proc.new { common? }

  kredis_unique_list :room_online_user_ids

  scope :recent, -> { order(created_at: :desc) }
  scope :common, -> { where(chat_type: :common) }
  scope :authored_by,  -> (email) { where(user: User.where(email: email)) }
  scope :favorited_by, -> (email) { joins(:favorites).where(favorites: { user: User.where(email: email) }) }

  # Set online status for Room instance
  def add_room_online_user(user_id)
    room_online_user_ids << user_id
  end

  def remove_room_online_user(user_id)
    room_online_user_ids.remove(user_id)
  end

  def online_room_users_count
    room_online_user_ids.elements.count
  end

  def room_online_users
    User.where(id: room_online_user_ids.elements)
  end

  def room_user_online?(id)
    id.to_s.in?(room_online_user_ids.elements)
  end

  # Set Favorite
  def favorite(user)
    favorites.create(user: user)
  end

  def unfavorite(user)
    favorites.where(user: user).destroy_all
    self.reload
  end

  private

  def generate_public_title
    self.title = SecureRandom.hex(3)
  end
end
