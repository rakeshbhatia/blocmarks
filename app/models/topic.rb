class Topic < ActiveRecord::Base
  has_many :bookmarks, dependent: :destroy
end
