class Bookmark < ActiveRecord::Base
  belongs_to :topic

  def user
    topic.user
  end
end
