class StoriesController < ApplicationController
    before_action :signed_in_user, only: [:create, :destroy]

  def new
    @story = Story.new
  end

  def index
    @stories = Story.paginate(page: params[:page], per_page: 11)
  end
  
  def create
    @story = current_user.stories.build(story_params)
    current_user.relationships.create(followed_id: @story.id)
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
    @comments = Comments.all #for now this needs to be find by commentable Id which needs to be the story id and saved when comments are saved!
    #@commentable = 
    #@comments = @commentable.comments.arrange(:order => :created_at)
    @comment = Comment.new
  


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

end
