class StoriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :set_default, only:[:create]

  def new
    @story = Story.new
  end

  def index
    @stories = Story.paginate(page: params[:page], per_page: 11)
  end

  def create
    @story = current_user.stories.build(story_params)
    current_user.relationships.create(followed_id: @story.id)
    @story.points = 1
    if @story.save
      flash[:success] = "Link Posted!"
      redirect_to root_url
    else
      render 'stories'
    end
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
    sign_in current_user
    session[:return_to] ||= request.referer
    @story = Story.find(params[:id])
    @story.points = @story.points.to_i + 1
    @story.save
    current_user.relationships.create(followed_id: @story.id)
    redirect_to session.delete(:return_to)
  end



  private

  def story_params
    params.require(:story).permit(:title, :url)
  end


  def find_commentable
    return params[:controller].singularize.classify.constantize.find(params[:id])
  end

  def set_default
    #self.points
  end

end
