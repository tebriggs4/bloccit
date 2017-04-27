class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
 
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
  
  after_create :send_favorite_emails
 
  private

  # When we create a comment we call send_favorite_emails. This finds the favorites associated with its 
  # comment's post, and loops over them. For each favorite, it will create and send a new email.
  def send_favorite_emails
    post.favorites.each do |favorite|
      FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
    end
  end
end
