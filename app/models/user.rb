class User < ApplicationRecord
  belongs_to :company

  has_many :tweets, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  scope :by_company, -> (identifier) { where(company: identifier) if identifier.present? }
  scope :like_username, -> (username) { where('username LIKE ?', "%#{username}%") if username.present? }
  scope :by_username, -> (username) { where(username: username) }

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end
end
