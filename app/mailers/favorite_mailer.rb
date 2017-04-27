class FavoriteMailer < ApplicationMailer
    default from: "tebriggs4@gmail.com"
    
    def new_comment(user, post, comment)
 
        # We set three different headers to enable conversation threading in different email clients.
        headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
        headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
        headers["References"] = "<post/#{post.id}@your-app-name.example>"
 
        @user = user
        @post = post
        @comment = comment
 
        # The mail method takes a hash of mail-relevant information - the subject the  to address, the from (we're using the default), 
        # and any cc or bcc information - and prepares the email to be sent.
        mail(to: user.email, subject: "New comment on #{post.title}")
    end
    
    def new_post(post)
 
        # We set three different headers to enable conversation threading in different email clients.
        headers["Message-ID"] = "<posts/#{post.id}@your-app-name.example>"
        headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
        headers["References"] = "<post/#{post.id}@your-app-name.example>"
 
        @post = post
        
        # The mail method takes a hash of mail-relevant information - the subject the  to address, the from (we're using the default), 
        # and any cc or bcc information - and prepares the email to be sent.
        mail(to: post.user.email, subject: "You created a new post and will not follow it #{post.title}")
    end
end
