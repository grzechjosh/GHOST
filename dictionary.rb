require 'set'
class Dictionary
    def initialize
        @dictionarySet = Set.new
        File.open('dictionary.txt').each do |line|
            @dictionarySet << line.chomp
        end   
    end
    def set
        @dictionarySet
    end
end