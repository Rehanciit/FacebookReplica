class LikesController < ApplicationController
  before_action :set_like, only: %i[ show ]
  before_action :require_login, only: %i[ create edit update destroy ]
  before_action :like_owner, only: %i[ edit update destroy]

  # POST /likes or /likes.json
  def create
    post = Post.find(params[:id])
    like = post.likes.build(user: current_user)
    
    if like.save
      redirect_to post_path(post), notice: 'Liked the post!'
    else
      redirect_to post_path(post), alert: 'Unable to like the post.'
    end
  end


  # DELETE /likes/1 or /likes/1.json
  def destroy
    post = Post.find(params[:id])
    like = Like.find_by(post:post,user:current_user)

    if like
      like.destroy
      redirect_to post_path(params[:id]), notice: 'Unliked the post!'
    else
      redirect_to post_path(params[:id]), alert: 'Unable to unlike the post.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.fetch(:like, {})
    end

    def require_login
      unless current_user
        redirect_to login_url, alert: 'Please log in as post owner.'
      end
    end

    def like_owner
      @post = Post.find(params[:id])
      @like = Like.find_by(post:@post,user:current_user)
      unless @like
        redirect_to login_url, alert: 'Please log in as owner.'
      end
    end
end
