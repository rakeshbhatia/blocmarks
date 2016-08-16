require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe '#format_url' do
    it "adds http to the beginning of the url if it's not there" do
      bookmark = Bookmark.new(url: "www.google.com")
      bookmark.format_url
      expect(bookmark.url).to eq("http://www.google.com")
    end
  end
end
