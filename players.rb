class Player
    def initialize(name)
        @playerName = name
    end
    def guess
        puts "Please enter a letter to guess."
        playerLetter = gets.chomp
        return playerLetter.downcase
    end
    def player_name
        return @playerName
    end
end 