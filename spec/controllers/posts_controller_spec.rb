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

  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
 
    it "renders the #edit view" do
      get :edit, {id: my_post.id}
        # We expect the edit view to render when a post is edited.
        expect(response).to render_template :edit
    end
 
    # We test that edit assigns the correct post to be updated to @post.
    it "assigns post to be updated to @post" do
      get :edit, {id: my_post.id}
 
      post_instance = assigns(:post)
 
      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end
  
  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
 
      put :update, id: my_post.id, post: {title: new_title, body: new_body}
 
      # We test that @post was updated with the title and body passed to update. We also test that @post's id was not changed.
      updated_post = assigns(:post)
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end
 
    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
 
      # We expect to be redirected to the posts show view after the update.
      put :update, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to my_post
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, {id: my_post.id}
      # We search the database for a post with an id equal to my_post.id. This returns an Array. 
      # We assign the size of the array to count, and we expect count to equal zero. This test asserts
      # that the database won't have a matching post after destroy is called.
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end
 
    it "redirects to posts index" do
      delete :destroy, {id: my_post.id}
      # We expect to be redirected to the posts index view after a post has been deleted.
     expect(response).to redirect_to posts_path
    end
  end

end
