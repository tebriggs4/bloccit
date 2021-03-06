class Topic < ActiveRecord::Base
    has_many :posts, dependent: :destroy
    # Because comments already depend on posts, they will also be deleted when a topic is deleted.
end
