require 'rails_helper'

# We describe the subject of the spec, WelcomeController.
RSpec.describe WelcomeController, type: :controller do
    describe "GET index" do
        it "renders the index template" do
            # Call the index method of WelcomeController.
            get :index
            # We expect the controller's response to render the index template.
            expect(response).to render_template("index")
        end
    end
    
    
    describe "GET about" do
        it "renders the about template" do
            get :about
            expect(response).to render_template("about")
        end
    end
end
