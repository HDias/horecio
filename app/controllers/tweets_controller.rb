class TweetsController < ApplicationController
  def index
    tweets = if params[:user_username].present?
              user_tweets
            else
              Tweet
            end

    if tweets.any?
      tweets = tweets.cursor_paginate(
        cursor: params[:cursor],
        limit: self.class.per_page
      )
    end

    render json: {
      tweets: tweets,
      next_cursor: tweets&.last&.id
    }
  end

  private

  def user_tweets
    user = User.by_username(params[:user_username]).take
    user&.tweets || []
  end

  def self.per_page
    20
  end
end
