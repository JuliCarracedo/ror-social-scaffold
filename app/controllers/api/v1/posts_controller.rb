class PostsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @posts = Post.all
      json_response(@posts)
    end
  
    def create
      @post = current_user.posts.new(post_params)
      if @post.save()
        json_response({message: 'Post was created'})
      else
        json_response({message: "Post couldn't be created"}, :error)
      end
    end
  
    private
    
    def post_params
      params.require(:post).permit(:content)
    end
  end
  