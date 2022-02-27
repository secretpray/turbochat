module ApplicationHelper
  def user_nav_name(user)
    content_tag(:span, user.username, class: "font-bold text-gray-400")
  end

  def room_name(room, user = nil)
    title = room.name ||= room.title
    heart = render_nav_icon(room, user)
    content_tag(:span, title.capitalize, class: ["font-bold", "text-gray-700", "capitalize"])
    .concat content_tag(:span, " ( #{room.favorites_count} #{heart} )",
                        class: ["font-light", "italic", "text-gray-500", "text-sm"],
                        id: "room_#{room.id}_favorites_count")
  end

  def render_nav_icon(room, user = nil)
    if user&.favorited?(room)
      '💙 '.html_safe #'&#10084;'
    else
      '🤍 '.html_safe # '&#9825;' '♡'
    end
  end
end
