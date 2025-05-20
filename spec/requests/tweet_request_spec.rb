require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe "#index" do
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

    context "when fetching tweets for a specific user" do
      let(:user) { create(:user, username: "max_auth") }

      before do
        10.times do |i|
          create(:tweet, user: user, created_at: (10 - i).days.ago)
        end
      end

      it "returns only tweets for that user" do
        get user_tweets_path(user.username)

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body["tweets"].length).to eq(3)
        expect(response.parsed_body["tweets"].map { |t| t["user_id"] }.uniq).to eq([user.id])
      end

      it "paginates user tweets using cursor" do
        get user_tweets_path(user.username)
        first_page_tweets = response.parsed_body["tweets"]
        cursor = response.parsed_body["next_cursor"]

        get user_tweets_path(user.username, cursor: cursor)

        expect(response.parsed_body["tweets"].length).to eq(3)
        expect(response.parsed_body["tweets"].map { |t| t["user_id"] }.uniq).to eq([user.id])
        expect(response.parsed_body["tweets"].first["id"]).to eq(user.tweets.where("id < ?", cursor).order(created_at: :desc).first.id)
      end

      it "returns 404 for non-existent user" do
        get user_tweets_path("non_existent_user")

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body["tweets"].length).to eq(0)
        expect(response.parsed_body["next_cursor"]).to be_nil
      end
    end
  end
end
