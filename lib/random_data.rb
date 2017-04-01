# We define RandomData as a module because it is a standalone library with no dependencies or inheritance
# requirements. Modules help keep common functions organized and reusable throughout our application. Unlike
# classes, we can't instantiate or inherit from modules. Instead we use them as mixins to add functions to multiple classes.
module RandomData
    # We define random_paragraph. We set sentences to an array. We create four to six random sentences and append them
    # to sentences. We call join on sentences to combine each sentence in the array, passing a space to separate each 
    # sentence. join combines each sentence into a full paragraph (as a string).
    def self.random_paragraph
        sentences = []
        rand(4..6).times do
            sentences << random_sentence
        end
 
        sentences.join(" ")
    end
 
    # We follow the same pattern as we did above to create a sentence with a random number of words. After we
    # generate a sentence, we call capitalize on it and append a period. capitalize returns a copy of sentence
    # with the first character converted to uppercase and the remainder of the sentence converted to lowercase.
    def self.random_sentence
        strings = []
        rand(3..8).times do
            strings << random_word
        end
 
        sentence = strings.join(" ")
        sentence.capitalize << "."
    end
 
    # We define random_word. We set letters to an array of the letters a through z using to_a. We call shuffle!
    # on letters in place. If we were to call shuffle without the bang (!), then shuffle would return an array 
    # rather than shuffle in place. We  join the zeroth through nth item in letters. The nth item is the result of
    # rand(3..8) which returns a random number greater than or equal to three and less than eight.
    def self.random_word
        letters = ('a'..'z').to_a
        letters.shuffle!
        letters[0,rand(3..8)].join
    end
end