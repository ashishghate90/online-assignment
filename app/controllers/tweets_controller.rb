class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :follow, :unfollow]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  def followers_tweets
    @followers = current_user.followers
    if @followers.present?
      ids = @followers.map(&:id).flatten
      @tweets = Tweet.where(user_id: ids).order("created_at DESC")
    end
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def follow
    relationship = Relationship.create(follower_id: @tweet.user.id, followed_id: current_user.id)
    if relationship.save
      redirect_to tweets_path, notice: "Followed successfully"
    else
      redirect_to tweets_path, notice: "Not Followed"
    end
  end

  def unfollow
    relationship = Relationship.where(follower_id: @tweet.user.id, followed_id: current_user.id)
    if relationship.delete_all
      redirect_to tweets_path, notice: "Unfollowed successfully"
    else
      redirect_to tweets_path, notice: "Not Worked"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:title, :description)
    end
end
