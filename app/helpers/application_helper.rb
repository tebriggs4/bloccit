module ApplicationHelper
    # We define a method named form_group_tag which takes two arguments. The first argument is an array of errors, and the second is a block.
    # The & turns the block into a Proc, which we've seen before but haven't named. A Proc is a block that can be reused like a variable.
    def form_group_tag(errors, &block)
        css_class = 'form-group'
        css_class << ' has-error' if errors.any?
        # The content_tag helper method is called. This method is used to build the HTML and CSS to display the form element and any associated errors.
        content_tag :div, capture(&block), class: css_class
    end
    
    def avatar_url(user)
        gravatar_id = Digest::MD5::hexdigest(user.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
    end
end
