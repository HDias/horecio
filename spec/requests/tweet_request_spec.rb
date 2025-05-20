require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe "GET /tweets" do
    before do
      allow(TweetsController).to receive(:per_page).and_return(3)
      10.times do |i|
        create(:tweet, created_at: (10 - i).days.ago)
      end
    end

    it "returns tweets ordered by most recent" do
      get tweets_path

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body["tweets"].length).to eq(3)
      expect(response.parsed_body["tweets"].map { |t| t["id"] }).to eq(Tweet.order(created_at: :desc).limit(3).pluck(:id))
    end

    it "paginates using cursor" do
      get tweets_path
      first_page_tweets = response.parsed_body["tweets"]
      cursor = response.parsed_body["next_cursor"]

      get tweets_path(cursor: cursor)

      expect(response.parsed_body["tweets"].length).to eq(3)
      expect(response.parsed_body["tweets"].first["id"]).to eq(Tweet.where("id < ?", cursor).order(created_at: :desc).first.id)
    end

    it "respects the per page limit" do
      create_list(:tweet, 5)

      get tweets_path

      expect(response.parsed_body["tweets"].length).to eq(3)
    end
  end
end
