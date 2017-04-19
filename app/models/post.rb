class Post < ActiveRecord::Base
    belongs_to :topic
    belongs_to :user
    has_many :comments, dependent: :destroy
    
    # The default_scope will order all posts by their created_at date, in descending order, with the most recent posts displayed first.
    default_scope { order('created_at DESC') }
    
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :topic, presence: true
    validates :user, presence: true
end
