class VotesController < ApplicationController
    # We require user to be signed-in before they're allowed to vote on a post.
    before_action :require_sign_in

    def up_vote
        update_vote(1)
        redirect_to :back
    end
    
    
    def down_vote
        update_vote(-1)
        redirect_to :back
    end
 
    private  
    def update_vote(new_value)
        @post = Post.find(params[:post_id])
        @vote = @post.votes.where(user_id: current_user.id).first
        
        # Update the vote if it exists, or create a new one if not
        if @vote
            @vote.update_attribute(:value, new_value)
        else
            @vote = current_user.votes.create(value: new_value, post: @post)
        end
    end
end
