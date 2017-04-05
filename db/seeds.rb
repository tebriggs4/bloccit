# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'

# Create Posts
50.times do
    # We use create! with a bang (!). Adding a ! instructs the method to raise an error if there's 
    # a problem with the data we're seeding. Using create without a bang could fail without warning,
    # causing the error to surface later.
    Post.create!(
        # We use methods from a class that does not exist yet, RandomData, that will create random strings
        # for title and body. Writing code for classes and methods that don't exist is known as "wishful coding"
        # and can increase productivity because it allows you to stay focused on one problem at a time.
        title:  RandomData.random_sentence,
        body:   RandomData.random_paragraph
    )
end
posts = Post.all
 
# Create Comments
# We call times on an Integer (a number object). This will run a given block the specified number of times,
# which is 100 in this case. The end result of calling times is similar to that of a loop, but in this use-case,
# it is easier to read and thus more idiomatic.
100.times do
    Comment.create!(
        # We call sample on the array returned by Post.all, in order to pick a random post to associate each comment with.
        # sample returns a random element from the array every time it's called.
        post: posts.sample,
        body: RandomData.random_paragraph
    )
end

100.times do
    Question.create!(
        title:  RandomData.random_sentence,
        body:   RandomData.random_paragraph,
        resolved: false
    )
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Question.count} questions created"
