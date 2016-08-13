class BookmarksController < ApplicationController
  #before_action :require_sign_in, except: [:index, :show]

  #before_action :authorize_user, except: [:index, :show]

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def create
    topic = Topic.find(params[:topic_id])

    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.topic = topic

    if @bookmark.save
      format_url
      flash[:notice] = "Bookmark was saved successfully."
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash.now[:alert] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      format_url
      flash[:notice] = "Bookmark was updated successfully."
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash.now[:alert] = "There was an error saving the bookmark. Please try again."
      render :edit
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the bookmark."
      render :show
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

  #def authorize_user
  #  unless user_is_authorized_for_bookmarks?
  #    flash[:alert] = "You must be the current user to do that."
  #    redirect_to bookmarks_path
  #  end
  #end
end
