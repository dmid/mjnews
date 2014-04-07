class CommentsController < ApplicationController
  def new
    @parent_id = params.delete(:parent_id)
    @commentable = find_commentable
    @comment = Comment.new( :parent_id => @parent_id, 
                            :commentable_id => @commentable.id,
                            :commentable_type => @commentable.class.to_s)
  end
  
 

def create 
  @comment = Comment.new(comment_params)
  if @comment.save
    flash[:success] = "Commented"
    redirect_to stories_path
  end
end



 
  private
  
def comment_params
  params.require(:comment).permit(:content)
end

  

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end