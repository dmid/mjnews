class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only:[:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome To Marijuana News! The Place For Discussion, Opinions, & Advice"
      redirect_to @user
      else
        render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @stories = @user.stories.paginate(page: params[:page], per_page: 10)
    @microposts = @user.microposts
  end

  def microposts
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end

  def edit
   @user = User.find(params[:id])
  end

def destroy
  User.find(params[:id]).destroy
  flash[:success] = "User deleted."
  redirect_to users_url
end

def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = "Profile updated"
    redirect_to @user
  else
    render 'edit'
  end
end

def following
  @title = "Saved Stories"
  @user = User.find(params[:id])
  @users = user.followed_stories.paginate(page: params[:page])
end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #before actions
  def signed_in_user
    unless signed_in?
      store_location #uh, send me back!
      redirect_to signin_url, notice: "Please Sign In."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end

#If I couldn't flow futuristic would ya?
