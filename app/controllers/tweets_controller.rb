class TweetsController < ApplicationController
  def index
    tweets = Tweet
      .cursor_paginate(
        cursor: params[:cursor],
        limit: self.class.per_page
      )

    render json: {
      tweets: tweets,
      next_cursor: tweets.last&.id
    }
  end

  private

  def self.per_page
    20
  end
end
