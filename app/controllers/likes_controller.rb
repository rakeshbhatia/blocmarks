class LikesController < ApplicationController
  def index
    @liked_bookmarks = Bookmark.joins(:like).all
  end

  def create
    bookmark = Bookmark.find(params[:bookmark_id])
    @like = current_user.likes.build(bookmark: bookmark)

    authorize(@like)

    if @like.save
      flash[:notice] = "Like was saved successfully."
      redirect_to [bookmark.topic, bookmark]
    else
      flash.now[:alert] = "Error liking the bookmark. Please try again."
      redirect_to [bookmark.topic, bookmark]
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:bookmark_id])
    @like = bookmark.likes.find(params[:id])

    authorize(@like)

    if @like.destroy
      flash[:notice] = "\"#{@like}\" was deletd successfully."
      redirect_to [bookmark.topic, bookmark]
    else
      flash.now[:alert] = "There was an error deleting the like."
      redirect_to [bookmark.topic, bookmark]
    end
  end
end
