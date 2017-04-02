require 'rails_helper'

# RSpec created a test for PostsController. type: :controller tells RSpec to treat the test as a 
# controller test. This allows us to simulate controller actions such as HTTP requests.
RSpec.describe PostsController, type: :controller do

  # We create a post and assign it to my_post using let. We use RandomData to give my_post a random title and body.
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
  
  describe "GET #index" do
    it "returns http success" do
      # The test performs a GET on the index view and expects the response to be successful.
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_post] to @posts" do
      get :index
      # Because our test created one post (my_post), we expect index to return an array of one item.
      # We use assigns, a method in ActionController::TestCase. assigns gives the test access to "instance
      # variables assigned in the action that are available for the view".
      expect(assigns(:posts)).to eq([my_post])
    end
  end
  
  # We comment out the tests for show, new, and edit since we won't write the implementation until later.
  
  #describe "GET #show" do
  #  it "returns http success" do
  #    get :show
  #    expect(response).to have_http_status(:success)
  #  end
  #end

  #describe "GET #new" do
  #  it "returns http success" do
  #    get :new
  #    expect(response).to have_http_status(:success)
  #  end
  #end

  #describe "GET #edit" do
  #  it "returns http success" do
  #    get :edit
  #    expect(response).to have_http_status(:success)
  #  end
  #end

end
