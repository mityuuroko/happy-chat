class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]
  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.destroy
      redirect_to root_path, notice: "削除しました"
    else
      flash.now[:alert] = "削除できませんでした"
      render :index
    end
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to root_path, notice: "更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :index
    end
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user) 
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end
  
  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
