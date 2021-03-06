class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]


  def index
    if params[:tag]
      @posts = Post.all.order("created_at DESC").tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 10)
    else
      @posts = Post.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
  end


  def new
    @post = current_user.posts.build
  end

  def like
    @post = Post.find(params[:id])
    @post.liked_by current_user

    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @post.get_upvotes.size, id: params[:id] } }
    end
  end

  def dislike
    @post = Post.find(params[:id])
    @post.disliked_by current_user

    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @post.get_upvotes.size, id: params[:id] } }
    end
  end

  def edit
  end


  def create
    @post = current_user.posts.build(post_params)

    if @post.save
     redirect_to @post, notice: 'Post was successfully created.'
      
    else
     render action: 'new'
     end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def find_post
      @post = Post.find(params[:id])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to posts_path, notice: "Not authorized to edit this post" if @post.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:description, :image, :tag_list)
    end
end
