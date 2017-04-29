# We define a factory for comments.
FactoryGirl.define do
    factory :comment do
        body RandomData.random_paragraph
        user
    end
end