class UsersController < ApplicationController
  def show
    # populate @user_bookmarks with the user's bookmarks
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks
    # populate @liked_bookmarks with liked bookmarks
    #@liked_bookmarks = @user.bookmarks.liked_by
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver_later

        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
