require "./player.rb"
require "./question.rb"
require 'io/console'                                                                                                       


class Game
    def initialize(lives = 3)
        @player_one = Player.new("Player 1", lives)
        @player_two = Player.new("Player 2", lives)
        @turn = 1
        @first_player_suffle = rand(0..1)
    end

    def play
        landing_page 
        choose_name                                                                                           
        game_loop
        end_game
        credits
    end

    # ----------
    private
    # ----------

    def active_player
      @turn % 2 == @first_player_suffle ? @player_one : @player_two
    end

    def terminate_turn
        @turn += 1
        puts"\n\nLIVES LEFT"
        puts"#{@player_one.name}: #{@player_one.hearts}"
        puts"#{@player_two.name}: #{@player_two.hearts}"
        sleep(2)                                                                                                             
    end

    def landing_page
      puts(`clear`)
      puts <<-'EOF'

      ░██████╗██╗░░░██╗██████╗░███████╗██████╗░  ███╗░░░███╗░█████╗░████████╗██╗░░██╗
      ██╔════╝██║░░░██║██╔══██╗██╔════╝██╔══██╗  ████╗░████║██╔══██╗╚══██╔══╝██║░░██║
      ╚█████╗░██║░░░██║██████╔╝█████╗░░██████╔╝  ██╔████╔██║███████║░░░██║░░░███████║
      ░╚═══██╗██║░░░██║██╔═══╝░██╔══╝░░██╔══██╗  ██║╚██╔╝██║██╔══██║░░░██║░░░██╔══██║
      ██████╔╝╚██████╔╝██║░░░░░███████╗██║░░██║  ██║░╚═╝░██║██║░░██║░░░██║░░░██║░░██║
      ╚═════╝░░╚═════╝░╚═╝░░░░░╚══════╝╚═╝░░╚═╝  ╚═╝░░░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝
      
      ░█████╗░██╗░░██╗░█████╗░██╗░░░░░██╗░░░░░███████╗███╗░░██╗░██████╗░███████╗
      ██╔══██╗██║░░██║██╔══██╗██║░░░░░██║░░░░░██╔════╝████╗░██║██╔════╝░██╔════╝
      ██║░░╚═╝███████║███████║██║░░░░░██║░░░░░█████╗░░██╔██╗██║██║░░██╗░█████╗░░
      ██║░░██╗██╔══██║██╔══██║██║░░░░░██║░░░░░██╔══╝░░██║╚████║██║░░╚██╗██╔══╝░░
      ╚█████╔╝██║░░██║██║░░██║███████╗███████╗███████╗██║░╚███║╚██████╔╝███████╗
      ░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚══════╝╚══════╝╚═╝░░╚══╝░╚═════╝░╚══════╝            
      EOF
      puts("\n\n\n      Press any key to start the game...")
      STDIN.getch  
    end

    def choose_name
      puts(`clear`)
      puts "🤙 | TELL ME YOUR COOL NAMES!"
      print "\nPlayer 1: "
      @player_one.set_name(gets.chomp)
      print "\nPlayer 2: "
      @player_two.set_name(gets.chomp)

      puts("\n\n\nPress any key when ready to prove who's the boss...")
      STDIN.getch  
    end

    def game_loop
      while @player_one.alive? && @player_two.alive?
        active_question = Question.new()
        puts(`clear`)
        puts "❓ | QUESTION FOR #{active_player.name.upcase}"
        sleep(0.25)
        print("\n==> #{active_question.prompt} ")

        active_question.answer(gets.chomp.to_i)
        
        puts(`clear`)
        puts "❓ | QUESTION FOR #{active_player.name.upcase}"
        if active_question.evaluate?
          puts "\n==> HELL YEAH #{active_player.name.upcase}! 🎉\n"
        else
          active_player.lose_life
          puts "\n==> 💩 Well, you suck #{active_player.name}! The correct answer was #{active_question.correct_answer}"
        end
        terminate_turn
      end
    end

    def end_game
      puts(`clear`)
      puts <<-'EOF'
            
      ██████╗░░█████╗░███╗░░██╗███████╗
      ██╔══██╗██╔══██╗████╗░██║██╔════╝
      ██║░░██║██║░░██║██╔██╗██║█████╗░░
      ██║░░██║██║░░██║██║╚████║██╔══╝░░
      ██████╔╝╚█████╔╝██║░╚███║███████╗
      ╚═════╝░░╚════╝░╚═╝░░╚══╝╚══════╝           
      EOF

      sleep(1)
      puts("\n\n\n      CONGRATULATION #{the_boss.name.upcase}, YOU'RE THE BOSS")
      sleep(3)
      puts("\n\n\n      (oh, and, #{the_loser.name}, you're really just a pile of 💩)")
      STDIN.getch  
    end
    def the_boss
      return @player_one if @player_one.alive?
      return @player_two if @player_two.alive?
    end

    def the_loser
      return @player_one if @player_one.alive? == false
      return @player_two if @player_two.alive? == false
    end

    def credits
      puts(`clear`)
      puts <<-'EOF'
                              
                              █▀▀ █▀█ █▀▀ ▄▀█ ▀█▀ █▀▀ █▀▄   █▄▄ █▄█
                              █▄▄ █▀▄ ██▄ █▀█ ░█░ ██▄ █▄▀   █▄█ ░█░          
      EOF
      puts(' ')
      puts <<-'EOF'   

      ██╗░░██╗███████╗██╗░░░██╗██╗███╗░░██╗  ███╗░░██╗██╗░█████╗░░█████╗░██╗░░░░░░█████╗░░██████╗
      ██║░██╔╝██╔════╝██║░░░██║██║████╗░██║  ████╗░██║██║██╔══██╗██╔══██╗██║░░░░░██╔══██╗██╔════╝
      █████═╝░█████╗░░╚██╗░██╔╝██║██╔██╗██║  ██╔██╗██║██║██║░░╚═╝██║░░██║██║░░░░░███████║╚█████╗░
      ██╔═██╗░██╔══╝░░░╚████╔╝░██║██║╚████║  ██║╚████║██║██║░░██╗██║░░██║██║░░░░░██╔══██║░╚═══██╗
      ██║░╚██╗███████╗░░╚██╔╝░░██║██║░╚███║  ██║░╚███║██║╚█████╔╝╚█████╔╝███████╗██║░░██║██████╔╝
      ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝╚═╝░░╚══╝  ╚═╝░░╚══╝╚═╝░╚════╝░░╚════╝░╚══════╝╚═╝░░╚═╝╚═════╝░          
      EOF
      STDIN.getch  
    end
end