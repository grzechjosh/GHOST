require 'byebug'
require_relative 'dictionary.rb'
require_relative 'players.rb'

class Game
    def initialize(*args)
        initPlayers = args
        @finalPlayers = []
        @losses = Hash.new(0)
        @record = Hash.new([])
        initPlayers.each do |name|
            @finalPlayers << Player.new(name)
            @losses[name] = 0
            @record[name] = ""
        end
        @fragment = []
        @dictionary = Dictionary.new
        @currentPlayer = @finalPlayers[0]
        @losses
        @finalPlayers.each
        @ghost = ["G", "H", "O", "S", "T"]                
    end
    def valid_play?(letter)
        guessArray = []
        @fragment.each do |letter1|
            guessArray << letter1
        end
        guessArray << letter
        @dictionary.set.each do |word|
            if word.include?(guessArray.join(""))
                return true
            end
        end
        return false
    end
    def match?
        if @dictionary.set.include?(@fragment.join(""))
            return true
        else
            return false
        end
    end
    def switch_turns
        @finalPlayers = @finalPlayers.rotate(1)
        @currentPlayer = @finalPlayers[0]
    end
    def play_round
        puts "The current player is #{@currentPlayer.player_name}"
        puts @record
        currentGuess = @currentPlayer.guess
        if valid_play?(currentGuess)
            @fragment << currentGuess
            puts "Looks like #{currentGuess} is part of a known word. It's been added to the string which is now #{@fragment.join("")}"
        else
            puts "That letter will not spell a known word. Please try again."
        end
        if self.match?
            index = @record[@currentPlayer.player_name].length
            @record[@currentPlayer.player_name] << @ghost[index]
            puts "#{@currentPlayer.player_name}, has earned a #{@ghost[index]}, for the completed word, #{@fragment.join("")}"
            @fragment = []
        end
        self.switch_turns
    end
    def run 
        while !@record.has_value?(@ghost)
            self.play_round
        end
        @record.each do |k,v|
            if v == "GHOST"
                @losses[k] += 1
                puts "#{k} has lost the game."
            end
        end
    end
end