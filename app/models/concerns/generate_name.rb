module GenerateName
  extend ActiveSupport::Concern

  MAX_COUNT = 12

  def generate_random_name(count = 0)
    return if count > MAX_COUNT # logger.debug "Generate try count: #{count} (in MAX_COUNT: #{MAX_COUNT})"

    random_name = RandomUsername.noun(:min_length => 4, :max_length => 8)
    return generate_random_name(count.next) if not_uniq_name?(random_name)

    update(name: random_name)
  end

  private

  def not_uniq_name?(name)
    Room.where(name: name).present?
  end
end
