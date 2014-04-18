require 'will_paginate/array'

class StoriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]


  def new
    @story = Story.new
  end

  def index
    @stories_hash = {}                  
    @stories = Story.all

    #Place stories in hash. Sort Hash, Place sorted hash into an array for easy display
    @stories.each do |story|
      #store this shit with ranking
      time_since_post = TimeDifference.between(Time.now, story.created_at).in_hours
      ranking = ((story.points.to_i - 1) / (time_since_post + 2)**1.5)
       a = story.id
      @stories_hash[a] = ranking
    end 
    @sorted_stories = @stories_hash.sort_by {|story, ranking| ranking}  #hash sort by ranking
    @display_stories = []
    counter = @sorted_stories.count

    @stories_hash.each {| storyid, rank |
      st = Story.find_by_id(storyid)
      st.rank = rank
} 
  @thesort = Story.order(:rank)
  @thesort = @thesort.reverse

  @thesort = @thesort.paginate(page: params[:page], per_page: 20 )
  



    

    #@sorted_stories.each do


    # while counter >= 0 do
      
    #   index = @sorted_stories[counter.to_i][0].to_i
    #   story = Story.find_by_id(index)
    #   @display_stories << story
    #   counter = counter - 1
    # end

     
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
    @micropost = Micropost.new
    @microposts = Micropost.find_by story_id: @story.id
  end

  def vote
    if current_user == nil
      flash[:notice] = "Please Sign In To Vote"
      redirect_to signin_path
    else
      session[:return_to] ||= request.referer
      @story = Story.find(params[:id])
      @story.points = @story.points.to_i + 1
      @story.save
      current_user.relationships.create(followed_id: @story.id)
      redirect_to session.delete(:return_to)
    end

  end


  private

  def story_params
    params.require(:story).permit(:title, :url)
  end


end
