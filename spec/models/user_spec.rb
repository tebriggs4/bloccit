require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { create(:user) }
    
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:votes) }
    it { is_expected.to have_many(:favorites) }
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
        expect(user).to have_attributes(name: user.name, email: user.email)
        end
        
        # We expect that users will respond to role.
        it "responds to role" do
            expect(user).to respond_to(:role)
        end
 
        # We expect users will respond to admin?, which will return whether or not a user is an admin. We'll 
        # implement this using the ActiveRecord::Enum class.
        it "responds to admin?" do
            expect(user).to respond_to(:admin?)
        end
 
        # We expect users will respond to member?, which will return whether or not a user is a member.
        it "responds to member?" do
            expect(user).to respond_to(:member?)
        end
    end

    describe "roles" do
        # We expect that users will be assigned the role of member by default.
        it "is member by default" do
            expect(user.role).to eql("member")
        end
 
        # We test member and admin users within separate contexts.
        context "member user" do
            it "returns true for #member?" do
                expect(user.member?).to be_truthy
            end
 
            it "returns false for #admin?" do
                expect(user.admin?).to be_falsey
            end
        end
 
        # We test member and admin users within separate contexts.
        context "admin user" do
            before do
                user.admin!
            end
 
            it "returns false for #member?" do
                expect(user.member?).to be_falsey
            end
 
            it "returns true for #admin?" do
                expect(user.admin?).to be_truthy
            end
        end
    end
    
    # We wrote a test that does not follow the same conventions as our previous tests. We are testing for a value
    # that we know should be invalid. We call this a true negative, as we are testing for a value that shouldn't exist. 
    # A true positive follows the reciprocal pattern and tests for a known and valid value. True negatives are a useful 
    # testing strategy, because if we only test for values that we know should exist, we may not catch values that shouldn't.
    describe "invalid user" do
        let(:user_with_invalid_name) { build(:user, name: "") }
        let(:user_with_invalid_email) { build(:user, email: "") }

 
        it "should be an invalid user due to blank name" do
            expect(user_with_invalid_name).to_not be_valid
        end
 
        it "should be an invalid user due to blank email" do
            expect(user_with_invalid_email).to_not be_valid
        end
    end
    
    describe "#favorite_for(post)" do
        before do
            topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
            @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
        end

        it "returns `nil` if the user has not favorited the post" do
            # We expect that favorite_for will return nil if the user has not favorited  @post.
            expect(user.favorite_for(@post)).to be_nil
        end
 
        it "returns the appropriate favorite if it exists" do
            # We create a favorite for user and @post.
            favorite = user.favorites.where(post: @post).create
            # We expect that favorite_for will return the favorite we created in the line before.
            expect(user.favorite_for(@post)).to eq(favorite)
        end
    end
    
    # We use . in describe ".avatar_url" because it is a class method and that is the RSpec convention.
    # RSpec conventions like this make it much easier to troubleshoot tests.
    describe ".avatar_url" do
        # We build a user with FactoryGirl. We pass email: "blochead@bloc.io" to  build, which overrides the email address
        # that would be generated in the factory with "blochead@bloc.io". We are overriding the default email address with 
        # a known one so that we can test against a specific string that we know Gravatar will return for the account "blochead@bloc.io".
        let(:known_user) { create(:user, email: "blochead@bloc.io") }
 
        it "returns the proper Gravatar url for a known email entity" do
        # We set the expected string that Gravatar should return for "blochead@bloc.io". The s=48 query parameter specifies that we want 
        # the returned image to be 48x48 pixels.
        expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
        # We expect known_user.avatar_url to return  http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48.
        expect(known_user.avatar_url(48)).to eq(expected_gravatar)
    end
end
end
