class Bookmark < ActiveRecord::Base
  before_save :format_url

  belongs_to :topic

  has_many :likes, dependent: :destroy

  def user
    topic.user
  end

  def format_url
    # Check to see if URL contains http or https. If it doesn't, add it before saving.
    match_string = /http:\/\//.match(url)

    # concatenate @bookmark.url with the string "https://"
    if match_string == nil
      match_string = "http://"
      match_string.concat(url)
      self.url = match_string
    end
  end
end
