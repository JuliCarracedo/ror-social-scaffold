class CommentsController < ApplicationController

    def index
      @comments = Post.find(params[:post_id]).comments
      json_response(@comments)
    end
  
    def create
      @comment = Comment.new(comment_params)
      @comment.post_id = params[:post_id]
      @comment.user = current_user
  
      if @comment.save
  
        multi_response(message: 'Comment Created')
   
      else
      respond_to do |format|
     
        multi_response(message: "Couldn't create comment", status: :error)
        
        end
      end
    end
  
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  