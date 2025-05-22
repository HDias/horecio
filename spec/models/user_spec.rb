require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'after_create callback' do
    it 'sends welcome email' do
      expect {
        create(:user)
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends email to the correct user' do
      user = create(:user)
      mail = ActionMailer::Base.deliveries.last

      expect(mail.to).to eq([user.email])
      expect(mail.subject).to eq("Welcome to #{user.company.name}!")
    end
  end
end
