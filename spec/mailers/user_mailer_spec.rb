require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe '#welcome' do
    let(:user) { create(:user) }
    let(:mail) { described_class.welcome(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq("Welcome to #{user.company.name}!")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(user.display_name)
      expect(mail.body.encoded).to include(user.company.name)
    end
  end

end
