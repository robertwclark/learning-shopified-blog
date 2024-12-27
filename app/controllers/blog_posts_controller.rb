class BlogPostsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_blog_post, only: %i[ show edit update ]

  def index
    @blog_posts = authenticated? ? BlogPost.sorted : BlogPost.published.sorted
  end
  def show
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
  end
  def new
    @blog_post = BlogPost.new
  end
  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
  end
  def update
      if @blog_post.update(blog_post_params)
          redirect_to @blog_post
      else
          render :edit, status: :unprocessable_entity
      end
  end
  private
      def set_blog_post
        @blog_post = authenticated? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          redirect_to root_path
      end
      def blog_post_params
          params.expect(blog_post: [ :title, :body, :published_at ])
      end
end
