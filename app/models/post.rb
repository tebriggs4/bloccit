class Post < ActiveRecord::Base
    belongs_to :topic
    belongs_to :user
    has_many :comments, dependent: :destroy
    # We add the votes association to Post. This relates the models and allows us to call post.votes. We also add 
    # dependent: :destroy to ensure that votes are destroyed when their parent post is deleted.
    has_many :votes, dependent: :destroy
    has_many :favorites, dependent: :destroy
    
    after_create :create_favorite
    
    # The default_scope will order all posts by their rank inn descending order.
    default_scope { order('rank DESC') }
    
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :topic, presence: true
    validates :user, presence: true
    
    
    def up_votes
        # We find the up votes for a post by passing value: 1 to where. This fetches a collection of votes with a value of 1.
        # We then call count on the collection to get a total of all up votes.
        votes.where(value: 1).count
    end
 
    def down_votes
        # We find the down votes for a post by passing value: -1 to where.  where(value: -1) fetches only the votes with a value of -1.
        # We then call count on the collection to get a total of all up votes.
        votes.where(value: -1).count
    end
 
    def points
        # We use ActiveRecord's sum method to add the value of all the given post's votes. Passing :value to 
        # sum tells it what attribute to sum in the collection.
        votes.sum(:value)
    end
    
    def update_rank
        age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
        new_rank = points + age_in_days
        update_attribute(:rank, new_rank)
    end
    
    def create_favorite
        Favorite.create(post: self, user: self.user)
        FavoriteMailer.new_post(self).deliver_now 
    end
   
end
