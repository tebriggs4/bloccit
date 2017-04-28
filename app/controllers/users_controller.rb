class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    # create is the action that is called when the new view's form is submitted with valid attributes.
    def create
        # We create a new user with new and then set the corresponding attributes from the params hash.
        @user = User.new
        @user.name = params[:user][:name]
        @user.email = params[:user][:email]
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
 
        # We save the new user to the database. If the database save is successful, we add a flash message
        # and then redirect the user to the root path. Otherwise, we display an error and render the new view.
        if @user.save
            flash[:notice] = "Welcome to Bloccit #{@user.name}!"
            create_session(@user)
            redirect_to root_path
        else
            flash.now[:alert] = "There was an error creating your account. Please try again."
            render :new
        end
    end
    
    def confirm
        
        @user = User.new
        @user.name = params[:user][:name]
        @user.email = params[:user][:email]
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
 
    end
    
    # We retrieve a user instance and set it to an instance variable.
    def show
        @user = User.find(params[:id])
        @posts = @user.posts.visible_to(current_user)
    end
end
