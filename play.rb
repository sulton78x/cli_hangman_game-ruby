class Hangman
    def initialize
        @letters = ('a'..'z').to_a
        @word = words.sample

        @lives = 7
        @correct_guesses = []

        @word_teaser = ""

        @word.first.size.times do
            @word_teaser +=  "_ "
        end
    end

    def words
        [
            ["cricket", "A game played by gentlemen..."],
            ["continent", "There are 7 of these..."],
            ["celebrate", "Remember memorable moments"],
            ["exotic", "Not from around here..."],
            ["jogging", "Neither walking nor running..."],
            ["football", "We all Love to watch Messi play..."],
        ]
    end

    def print_teaser last_guess = nil
        update_teaser(last_guess) unless last_guess.nil?
        puts @word_teaser
    end

    def update_teaser last_guess
        new_teaser = @word_teaser.split

        new_teaser.each_with_index do |letter, index|
            # replace blank spaces with values if it matches guessed letter.
            if letter = '_' && @word.first[index] == last_guess
                new_teaser[index] = last_guess
            end
        end

        @word_teaser = new_teaser.join(' ')
    end

    def make_guess
        if @lives > 0
            puts "Enter a Letter ..."

            guess = gets.chomp

            # if letter is part of word, then remove from letters array.
            good_guess = @word.first.include? guess

            if guess == 'exit'
                puts "Thanks for Playing."
            elsif good_guess
                puts "Good Guess"

                @correct_guesses << guess

                # remove correct guess from alphabet
                @letters.delete guess

                print_teaser guess

                if @word.first == @word_teaser.split.join
                    puts "Congratulations... You've won this round!."
                else
                    make_guess
                end
            else
                @lives -= 1
                puts "You have #{ @lives } tries left. Sorry, try again."
                make_guess
            end
        else
            puts "Game Over! Better Luck Next Time."
        end
    end

    def begin
        # ask user for a letter
        puts "New game started..."
        puts "Type 'exit' to Quit game any time."
        puts "Question : The Word is #{ @word.first.size } characters long."

        print_teaser

        puts "Hint: #{ @word.last } "
        
        make_guess

        # if (guess == "#{ @word.first }")
        #     puts "Correct!"
        # else
        #     puts "Sorry, try again."
        # end
    end
end

game = Hangman.new
game.begin