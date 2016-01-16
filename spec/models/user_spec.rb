require 'spec_helper'

describe User do
  let(:valid_attributes) {
    {
      first_name: "Eric",
      last_name: "Zell",
      email: "ericjzell@gmail.com"
    }
  }
  context 'validations' do

    before do
      User.create(valid_attributes)
    end

    let(:user) { User.new(valid_attributes) }

    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email case insensitive" do
      user.email = "ERICJZELL@GMAIL.COM"
      expect(user).to validate_uniqueness_of(:email)
    end

  end

  describe "#downcase_email" do
    it "makes the email attribute all lowercase" do
      user = User.new(valid_attributes.merge(email: "ERIC@GMAIL.COM"))
      expect{ user.downcase_email }.to change{ user.email }.
        from("ERIC@GMAIL.COM").to("eric@gmail.com")
    end

    it "downcases an email before saving to the database" do
      user = User.new(valid_attributes)
      user.email = "MIKE@GMAIL.COM"
      expect(user.save).to be_true
      expect(user.email).to eq("mike@gmail.com")
    end
  end
end
