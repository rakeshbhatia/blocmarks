module UsersHelper
  def liked_bookmarks_in_topic_by_user(topic, user)
    topic.bookmarks.joins(:likes).where(likes: { user_id: user.id })
  end

  def bookmarks_in_topic_by_user(topic, user)
    topic.bookmarks.where(user_id: user.id)
  end
end
