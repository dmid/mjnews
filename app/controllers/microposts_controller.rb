class MicropostsController < ApplicationController
before_action :signed_in_user, only: [:create, :destroy]

  def new
    @micropost = Micropost.new(parent_id: params[:parent_id])
  end

  def index

  end

  def create
    @micropost = current_user.microposts.build(micropost_params)

    @micropost.story_id = @micropost.root.story_id
    
    if @micropost.save
        flash[:success] = "Will BreakSoon"
    end
    redirect_to root_url
  end




  def destroy
  end

  private

  def micropost_params
    params.require(:micropost).permit(:user_id, :comment_id,:story_id, :content, :parent_id)
  end

end
