class LikesController < ApplicationController
  def index
    @liked_bookmarks = Bookmark.joins(:like).all
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    authorize(like)

    if like.save
      # Add code to generate a success flash and redirect to @bookmark
      flash[:notice] = "Like was saved successfully."
      redirect_to [@bookmark.topic, @bookmark]
    else
      # Add code to generate a failure flash and redirect to @bookmark
      flash.now[:alert] = "Error liking the bookmark. Please try again."
      redirect_to [@bookmark.topic, @bookmark]
      #render :new
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:bookmark_id])
    @like = bookmark.likes.find(params[:id])

    authorize(@like)

    if @like.destroy
      # Flash success and redirect to @bookmark
      flash[:notice] = "\"#{@like}\" was deleted successfully."
      redirect_to [@bookmark.topic, @bookmark]
      #redirect_to action: :index
    else
      # Flash error and redirect to @bookmark
      flash.now[:alert] = "There was an error deleting the like."
      redirect_to [@bookmark.topic, @bookmark]
      #render :show
    end
  end
end
