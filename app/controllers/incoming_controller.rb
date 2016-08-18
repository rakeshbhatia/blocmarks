class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!

  def create
    puts "INCOMING PARAMS HERE: #{params}"

    @user = User.find_by(email: params[:sender])

    @url = params["body-plain"]

    if @user.nil?
      @user = User.new(email: params[:sender], password: "password")
      @user.skip_confirmation!
      if @user.save!
        UserMailer.welcome_email(@user).deliver_now
      end
    end

    @topic = Topic.find_or_create_by(title: params[:subject])

    @bookmark = @topic.bookmarks.create(url: @url)

    head 200
  end
end
