module SessionsHelper
    # We define create_session. create_session sets user_id on the session object to user.id, which is unique
    # for each user. session is an object Rails provides to track the state of a particular user. There is a one-to-one
    # relationship between session objects and user ids. A one-to-one relationship means that a session object can only
    # have one user id and a user id is related to one session object.
    def create_session(user)
        session[:user_id] = user.id
    end
 
    # We define destroy_session. We clear the user id on the session object by setting it to nil, which effectively destroys
    # the user session because we can't track it via their user id any longer.
    def destroy_session(user)
        session[:user_id] = nil
    end
 
    # We define current_user, which returns the current user of the application.  current_user encapsulates the pattern of
    # finding the current user that we would otherwise call throughout Bloccit. Thus we won't have to constantly call
    # User.find_by(id: session[:user_id]); current_user is our shortcut to that functionality. 
    def current_user
        User.find_by(id: session[:user_id])
    end
end
