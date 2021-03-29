class Player
    attr_reader :starting_lives
    attr_reader :lives_left
    attr_reader :name
    def initialize(name, lives = 3)
        @starting_lives = lives
        @lives_left = lives
        @name = name
    end

    def lose_life
        @lives_left -= 1
    end

    def alive?
        @lives_left > 0
    end

    def hearts
        hearts =  ""
        @lives_left.times {hearts += "❤️ "}
        (@starting_lives - @lives_left).times {hearts += "💥 "}
        return hearts
    end

    def set_name(name)
        @name = name unless name == "" 
    end

end