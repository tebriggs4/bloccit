# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'

# Create Users
5.times do
    User.create!(
        # We wishful-coded two methods that we'll need to add to RandomData
        name:     RandomData.random_name,
        email:    RandomData.random_email,
        password: RandomData.random_sentence
    )
end
    
users = User.all

# Create Topics
15.times do
    Topic.create!(
        name:         RandomData.random_sentence,
        description:  RandomData.random_paragraph
    )
end
topics = Topic.all

# Create Posts
50.times do
    # We use create! with a bang (!). Adding a ! instructs the method to raise an error if there's 
    # a problem with the data we're seeding. Using create without a bang could fail without warning,
    # causing the error to surface later.
    post = Post.create!(
        # We use methods from a class that does not exist yet, RandomData, that will create random strings
        # for title and body. Writing code for classes and methods that don't exist is known as "wishful coding"
        # and can increase productivity because it allows you to stay focused on one problem at a time.
        user:   users.sample,
        topic:  topics.sample,
        title:  RandomData.random_sentence,
        body:   RandomData.random_paragraph
    )
    
    # We update the time a post was created. This makes our seeded data more realistic and will allow us to 
    # see our ranking algorithm in action later in the checkpoint.
    post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
    # We create between one and five votes for each post. [-1, 1].sample randomly creates either an up vote or a down vote.
    rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end
posts = Post.all
 
# Create Comments
# We call times on an Integer (a number object). This will run a given block the specified number of times,
# which is 100 in this case. The end result of calling times is similar to that of a loop, but in this use-case,
# it is easier to read and thus more idiomatic.
100.times do
    Comment.create!(
        user: users.sample,
        # We call sample on the array returned by Post.all, in order to pick a random post to associate each comment with.
        # sample returns a random element from the array every time it's called.
        post: posts.sample,
        body: RandomData.random_paragraph
    )
end

# Create an admin user
admin = User.create!(
    name:     'Admin User',
    email:    'admin@example.com',
    password: 'helloworld',
    role:     'admin'
)
 
# Create a member
member = User.create!(
    name:     'Member User',
    email:    'member@example.com',
    password: 'helloworld'
)
 
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"