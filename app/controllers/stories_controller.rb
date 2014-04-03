class StoriesController < ApplicationController
  def index
    @stories = Story.paginate(page: params[:page])
  end
  
  def followers
    @title = "Voters"
    @story = Story.find(params[:id])
    @users = @story.followers_users.paginate(page: params[:page])

  end

  def show
    @story = Story.find(params[:id])
  end

  def vote
    @story = Story.find(params[:id])
    @story.points = @story.points.to_i + 1
    @story.save
  
   current_user.relationships.create(followed_id: @story.id)
   redirect_to root_url
  end
end
