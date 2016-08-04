class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts "INCOMING PARAMS HERE: #{params}"
    # You put the message-splitting and business
    # magic here.

    # Email of user
    # Find the user by using params[:sender]
    @user = User.find_by(email: params[:sender])

    # Title of Topic
    # Find the topic by using params[:subject]
    @topic = Topic.find_by(title: params[:subject])

    # URL of Bookmark
    # Assign the url to a variable after retreiving it from params["body-plain"]
    @url = params["body-plain"]

    # Check if user is nil, if so, create and save a new user
    # Topic.find_or_create_by(title: params[:subject])
    # Check if the topic is nil, if so, create and save a new topic
    if @user.nil?
      @user = User.new(email: params[:sender], password: "password")
      @user.skip_confirmation!
      @user.save!
    end

    @topic = @user.topics.find_or_create_by(title: params[:subject])

    # Now that you're sure you have a valid user and topic, build and save a new bookmark
    @bookmark = @topic.bookmarks.create(url: @url)

    # Assuming all went well.
    head 200
  end
end
