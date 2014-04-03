class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
      @story = Story.find(params[:relationship][:followed_id])
     current_user.follow!(@story.id)
      respond_to do |format|
      format.html {redirect_to @story}
      format.js
    end
  end

  def destroy
    @story = Relationship.find(params[:id]).followed
    current_user.unfollow!(@story)
    redirect_to @stories
  end


  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please Sign In." 
    end
  end
end
