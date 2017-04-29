module UsersHelper
    def user_has_posts?(user)
        user.posts.count != 0
    end
    
    def user_has_comments?(user)
        user.comments.count !=0
    end
    
    def my_favorites(user)
        my_fav = []
        user.favorites.each do |post|
            my_fav << post
        end
        return my_fav
    end
end
