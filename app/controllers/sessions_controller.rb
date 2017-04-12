class SessionsController < ApplicationController
    def new
    end
 
    def create
        # We search the database for a user with the specified email address in the  params hash.
        # We use downcase to normalize the email address since the addresses stored in the database are stored as lowercase strings.
        user = User.find_by(email: params[:session][:email].downcase)

        # We verify that user is not nil and that the password in the params hash matches the specified password. The conditional
        # statement will exit early if user is  nil, because it checks for that first. This order of execution will prevent a null
        # pointer exception when user.authenticate is called if user is nil. If the user is successfully authenticated, we call a
        # create_session function (which we have yet to define), display a flash notice, and then redirect the user to root_path. 
        # If authentication was not successful, we flash a warning message and render the new view.
        if user && user.authenticate(params[:session][:password])
            create_session(user)
            flash[:notice] = "Welcome, #{user.name}!"
            redirect_to root_path
        else
            flash.now[:alert] = 'Invalid email/password combination'
            render :new
        end
    end
 
    def destroy
        # We define destroy. This method will delete a user's session. destroy logs the user out
        # by calling destroy_session(current_user), flashes a notice that they've been logged out, and redirects them to root_path.
        destroy_session(current_user)
        flash[:notice] = "You've been signed out, come back soon!"
        redirect_to root_path
    end
end
