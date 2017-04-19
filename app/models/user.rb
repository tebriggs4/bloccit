class User < ActiveRecord::Base
    has_many :posts
    # We register an inline callback directly after the before_save callback.  
    # { self.email = email.downcase } is the code that will run when the callback executes.
    before_save { self.email = email.downcase if email.present? }
    before_save { self.role ||= :member }

    # We use Ruby's validates function to ensure that name is present and has a maximum and minimum length.
    validates :name, length: { minimum: 1, maximum: 100 }, presence: true
    # We validate password with two separate validations: The first validation executes if password_digest is nil.
    # This ensures that when we create a new user, they have a valid password. The second validation ensures that when
    # updating a user's password, the updated password is also six characters long. allow_blank: true skips the validation 
    # if no updated password is given. This allows us to change other attributes on a user without being forced to set the password.
    validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
    validates :password, length: { minimum: 6 }, allow_blank: true
    # We validate that email is present, unique, case insensitive, has a minimum length, has a maximum length, and that
    # it is a properly formatted email address.
    validates :email,
        presence: true,
        uniqueness: { case_sensitive: false },
        length: { minimum: 3, maximum: 254 }

    # We use Ruby's has_secure_password. has_secure_password "adds methods to set and authenticate against a BCrypt password.
    # This mechanism requires you to have a password_digest attribute". 
    has_secure_password
    
    enum role: [:member, :admin]
end
