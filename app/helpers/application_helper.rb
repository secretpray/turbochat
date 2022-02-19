module ApplicationHelper
  def user_nav_name(user)
    content_tag(:span, user.username, class: "font-bold text-gray-400")
  end

  def room_name(room)
    title = room.name ||= room.title
    content_tag(:span, title.capitalize, class: ["font-bold", "text-gray-200", "capitalize"])
    .concat content_tag(:span, " (in #{room.favorites_count} Favorites)",
                        class: ["font-light", "italic", "text-gray-300", "text-sm"],
                        id: "room_#{room.id}_favorites_count")
  end
end
