class Bookmark < ActiveRecord::Base
  before_save :format_url

  belongs_to :topic
  belongs_to :user

  has_many :likes, dependent: :destroy

  def format_url
    match_string = /http:\/\//.match(url)

    if match_string == nil
      match_string = "http://"
      match_string.concat(url)
      self.url = match_string
    end
  end

  def self.liked_by(user)
    Bookmark.joins(:likes).where(likes: { user_id: user.id })
  end
end
