require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password") }
    # Shoulda tests for name
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(1) }
 
    # Shoulda tests for email
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_least(3) }
    it { is_expected.to allow_value("user@bloccit.com").for(:email) }
 
    # Shoulda tests for password
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
     
    describe "attributes" do
        it "should have name and email attributes" do
        expect(user).to have_attributes(name: "Bloccit User", email: "user@bloccit.com")
        end
        
        it "should format name" do
            user.name = "tara briggs"
            user.save
            expect(user.name).to eq "Tara Briggs"
        end
    end
    
    # We wrote a test that does not follow the same conventions as our previous tests. We are testing for a value
    # that we know should be invalid. We call this a true negative, as we are testing for a value that shouldn't exist. 
    # A true positive follows the reciprocal pattern and tests for a known and valid value. True negatives are a useful 
    # testing strategy, because if we only test for values that we know should exist, we may not catch values that shouldn't.
    describe "invalid user" do
        let(:user_with_invalid_name) { User.new(name: "", email: "user@bloccit.com") }
        let(:user_with_invalid_email) { User.new(name: "Bloccit User", email: "") }
 
        it "should be an invalid user due to blank name" do
            expect(user_with_invalid_name).to_not be_valid
        end
 
        it "should be an invalid user due to blank email" do
            expect(user_with_invalid_email).to_not be_valid
        end
    end
end
