class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :require_login, only: [:create, :edit, :update, :destroy]
  before_action :comment_owner, only: [ :edit, :update, :destroy]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show

  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
    def create
      comment=params[:comment]
      post_id=comment[:post_id]
      
      @post = Post.find(post_id)

      @parent_comment = Comment.find(params[:comment_id]) if params[:comment_id].present?
  
      @comment = @post.comments.build(comment_params)
      @comment.parent_comment = @parent_comment if @parent_comment
      
      if @comment.save
        redirect_to @post, notice: 'Comment created successfully.'
      else
        redirect_to @post, alert: 'Failed to create comment.'
      end
    end
  

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content,:post_id,:parent_comment_id).merge(user_id: current_user.id)
    end

    def require_login
      unless current_user
        redirect_to login_url, alert: 'Please log in.'
      end
    end

    def comment_owner
      unless @comment.user_id==current_user.id
        redirect_to login_url, alert: 'Please log in as comment owner.'
      end
    end

end
