require 'rails_helper'

RSpec.describe Advertisement, type: :model do
    let(:advertisement) { Advertisement.create! }
 
    # We test whether post has attributes named title and body. This tests whether post will return
    # a non-nil value when post.title and post.body is called.
    describe "attributes" do
        it "should respond to title" do
            expect(advertisement).to respond_to(:title)
        end
        it "should respond to body" do
            expect(advertisement).to respond_to(:body)
        end
        it "should respond to price" do
            expect(advertisement).to respond_to(:price)
        end
    end
end
