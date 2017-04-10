require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  
    let(:name) { RandomData.random_sentence }
    let(:description) { RandomData.random_paragraph }
    let(:title) { RandomData.random_sentence }
    let(:body) { RandomData.random_paragraph }
    let(:price) { 99 }
    
    # We create a parent topic for sponsored_post.
    let(:topic) { Topic.create!(name: name, description: description) }
    
    # We associate sponsored_post with topic via topic.sponsored_posts.create!. This is a chained method call which
    # creates a sponsored_post for a given topic.
    let(:sponsored_post) { topic.sponsored_posts.create!(title: title, body: body, price: price) }
 
    it { is_expected.to belong_to(:topic) }
 
    # We test whether post has attributes named title and body. This tests whether post will return
    # a non-nil value when post.title and post.body is called.
    describe "attributes" do
        it "has title and body and price attributes" do
            expect(sponsored_post).to have_attributes(title: title, body: body, price: price)
        end
    end
end
