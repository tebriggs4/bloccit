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
  
  # When new is invoked, a new and unsaved Post object is created. When create is invoked, the newly created
  # object is persisted to the database. This implementation mimics the RESTful parts of HTTP. Per HTTP, GET requests
  # should not generate new data, thus new (which is a GET) does not create data. POST requests are used to create
  # new data, thus create actually creates the fields in a post.
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
 
    # We expect PostsController#new to render the posts new view. We use the  render_template method
    # to verify that the correct template (view) is rendered.
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
 
    # We expect the @post instance variable to be initialized by  PostsController#new. assigns gives us
    # access to the @post variable, assigning it to  :post.
    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end
 
  describe "POST create" do
    # We expect that after PostsController#create is called with the parameters
    # {post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}, the count of
    # Post instances (i.e. rows in the posts table) in the database will increase by one.
    it "increases the number of Post by 1" do
    expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end
 
    # When create is POSTed to, we expect the newly created post to be assigned to @post.
    it "assigns the new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq Post.last
    end
 
    # We expect to be redirected to the newly created post.
    it "redirects to the new post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Post.last
    end
  end

  describe "GET show" do
    it "returns http success" do
      # We pass {id: my_post.id} to show as a parameter. These parameters are passed to the params hash.
      # The params hash contains all parameters passed to the application's controller (application_controller.rb),
      # whether from GET, POST, or any other HTTP action.
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
      # We expect the response to return the show view using the render_template matcher.
      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end
 
    it "assigns my_post to @post" do
      get :show, {id: my_post.id}
      # We expect the post to equal my_post because we call show with the id of my_post.
      # We are testing that the post returned to us is the post we asked for.
      expect(assigns(:post)).to eq(my_post)
    end
  end

  #describe "GET #edit" do
  #  it "returns http success" do
  #    get :edit
  #    expect(response).to have_http_status(:success)
  #  end
  #end

end
