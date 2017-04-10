require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do

  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
 
  let(:my_sponsored_post) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 9) }
  

  describe "GET #show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #new view" do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end
 
    it "instantiates @sponsored_post" do
      get :new, topic_id: my_topic.id
      expect(assigns(:sponsored_post)).not_to be_nil
    end
  end

  describe "POST create" do
    # We expect that after SponsoredPostsController#create is called with the parameters
    # {sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}, the count of
    # SponsoredPost instances (i.e. rows in the sponsored_posts table) in the database will increase by one.
    it "increases the number of SponsoredPost by 1" do
      # Update the post :create request to include the id of the parent topic.
      expect{post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99}}.to change(SponsoredPost,:count).by(1)
    end
 
    # When create is POSTed to, we expect the newly created sponsored_post to be assigned to @sponsored_post.
    it "assigns the new sponsored_post to @sponsored_post" do
      # Update the post :create request to include the id of the parent topic.
      post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99}
      expect(assigns(:sponsored_post)).to eq SponsoredPost.last
    end
 
    # We expect to be redirected to the newly created sponsored_post.
    it "redirects to the new sponsored_post" do
      # Update the post :create request to include the id of the parent topic.
      post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 99}
      # Because the route for the sponsored_posts show view will also be updated to reflect nested sponsored_posts, instead of redirecting 
      # to SponsoredPost.last, we redirect to  [my_topic, SponsoredPost.last]. Rails' router can take an array of objects and build a route 
      # to the show page of the last object in the array, nesting it under the other objects in the array.
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
      expect(response).to have_http_status(:success)
    end
 
    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
      # We expect the edit view to render when a sponsored_post is edited.
      expect(response).to render_template :edit
    end
 
    it "assigns sponsored_post to be updated to @sponsored_post" do
      get :edit, topic_id: my_topic.id, id: my_sponsored_post.id
 
      sponsored_post_instance = assigns(:sponsored_post)
 
      expect(sponsored_post_instance.id).to eq my_sponsored_post.id
      expect(sponsored_post_instance.title).to eq my_sponsored_post.title
      expect(sponsored_post_instance.body).to eq my_sponsored_post.body
      expect(sponsored_post_instance.price).to eq my_sponsored_post.price
    end
  end
  
  describe "PUT update" do
    it "updates sponsored_post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = 99
 
      put :update, topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: {title: new_title, body: new_body, price: new_price}
 
      updated_sponsored_post = assigns(:sponsored_post)
      expect(updated_sponsored_post.id).to eq my_sponsored_post.id
      expect(updated_sponsored_post.title).to eq new_title
      expect(updated_sponsored_post.body).to eq new_body
      expect(updated_sponsored_post.price).to eq new_price
    end
 
    it "redirects to the updated sponsored_post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = 99
 
      put :update, topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: {title: new_title, body: new_body, price: new_price}
      expect(response).to redirect_to [my_topic, my_sponsored_post]
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the sponsored_post" do
      delete :destroy, topic_id: my_topic.id, id: my_sponsored_post.id
      # We search the database for a sponsored_post with an id equal to my_sponsored_post.id. This returns an Array. 
      # We assign the size of the array to count, and we expect count to equal zero. This test asserts
      # that the database won't have a matching sponsored_post after destroy is called.
      count = SponsoredPost.where({id: my_sponsored_post.id}).size
      expect(count).to eq 0
    end
 
      it "redirects to topic show" do
      # We update the delete :destroy request to include the id of the parent topic.
      delete :destroy, topic_id: my_topic.id, id: my_sponsored_post.id
      # We want to be redirected to the topics show view instead of the posts index view.
      expect(response).to redirect_to my_topic
      
    end
  end
  
end
