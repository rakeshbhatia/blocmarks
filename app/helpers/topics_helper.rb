module TopicsHelper
  def first_four_bookmarks(topic)
    topic.bookmarks.first(4)
  end

  def all_bookmarks(topic)
    topic.bookmarks
  end
end
