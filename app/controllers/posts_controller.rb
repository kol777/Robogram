class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:edit, :update, :destroy, :show]
  # before_action :set_post, :like

  def find_post
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Something went wrong, please recheck your form!'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = 'Post updated successfully!'
      redirect_to(posts_path(@post))
    else
      flash.now[:alert] = 'Update failed! Recheck your form!'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def like
    @post = Post.find(params[:id])
    if @post.liked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def owned_post
    @post = Post.find(params[:id])
    unless current_user.id == @post.user_id
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

end
