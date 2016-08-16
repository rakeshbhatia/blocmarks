class Bookmark < ActiveRecord::Base
  before_save :format_url

  belongs_to :topic

  has_many :likes, dependent: :destroy

  def user
    topic.user
  end

  def format_url
    match_string = /http:\/\//.match(url)

    if match_string == nil
      match_string = "http://"
      match_string.concat(url)
      self.url = match_string
    end
  end

  def liked_by(user)
    Bookmark.joins(:like).where(like: { user_id: user.id })
  end
end
