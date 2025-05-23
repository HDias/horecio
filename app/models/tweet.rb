class Tweet < ApplicationRecord
  belongs_to :user, optional: true

  def self.cursor_paginate(cursor: nil, limit:)
    query = order(created_at: :desc)
    query = query.where("id < ?", cursor) if cursor.present?
    query.limit(limit)
  end
end
