class Room < ApplicationRecord
  include GenerateName
  has_many :messages, -> { sorted }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user

  before_create { self.title = SecureRandom.hex(3) }
  after_create_commit :generate_random_name

  kredis_unique_list :room_online_user_ids

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

  def favorite(user)
    favorites.create(user: user)
  end

  def unfavorite(user)
    favorites.where(user: user).destroy_all
    # The reason we call reload on the room after we unfavorite it is so that we
    # get an up to date version of the record with the correct favorites_count
    # value for the room.
    self.reload
  end
end
